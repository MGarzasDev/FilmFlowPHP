<?php
session_name("login");
session_start();

//Si el usuario no ha iniciado sesión he inetnta acceder a mostrar datos
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit;
}

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "FilmFlowDB";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$user_id = $_SESSION['user_id'];

$sql = "SELECT * FROM usuarios WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

//Cambiar datos del usuario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $current_password = $_POST['current_password'];

    if (password_verify($current_password, $user['contrasena'])) {
        //Obtenemos los nuevos datos introudidos
        $new_name = $_POST['fname'];
        $new_surname = $_POST['lname'];
        $new_nickname = $_POST['nickname'];
        $new_email = $_POST['email'];
        $new_password = $_POST['new_password'];
        $confirm_password = $_POST['confirm_new_password'];

        if ($new_nickname != $user['nickname']) {
            $check_nickname = "SELECT * FROM usuarios WHERE nickname = ?";
            $stmt = $conn->prepare($check_nickname);
            $stmt->bind_param("s", $new_nickname);
            $stmt->execute();
            if ($stmt->get_result()->num_rows > 0) {
                echo "<script>alert('El nombre de usuario ya está en uso');</script>";
                return;
            }
        }

        if ($new_email != $user['email']) {
            $check_email = "SELECT * FROM usuarios WHERE email = ?";
            $stmt = $conn->prepare($check_email);
            $stmt->bind_param("s", $new_email);
            $stmt->execute();
            if ($stmt->get_result()->num_rows > 0) {
                echo "<script>alert('El correo electrónico ya está en uso');</script>";
                return;
            }
        }

        $update_user = "UPDATE usuarios SET nombre = ?, apellidos = ?, nickname = ?, email = ? WHERE id = ?";
        $stmt = $conn->prepare($update_user);
        $stmt->bind_param("ssssi", $new_name, $new_surname, $new_nickname, $new_email, $user_id);
        $stmt->execute();

        //Si se ha pasado una nueva contraseña
        if (!empty($new_password) && !empty($confirm_password)) {
            if ($new_password == $confirm_password) {
                $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);
                $update_password = "UPDATE usuarios SET contrasena = ? WHERE id = ?";
                $stmt = $conn->prepare($update_password);
                $stmt->bind_param("si", $hashed_password, $user_id);
                $stmt->execute();
            } else {
                echo "<script>alert('Las contraseñas no coinciden');</script>";
            }
        }

        header("Location: mostrardatos.php");
    } else {
        echo "<script>alert('La contraseña proporcionada es incorrecta');</script>";
    }
}

//Actualizar la foto
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obtener la información del archivo de imagen
    $file_name = $_FILES["photo"]["name"];
    $file_tmp = $_FILES["photo"]["tmp_name"];
    $file_type = $_FILES["photo"]["type"];
    $file_size = $_FILES["photo"]["size"];
    $file_error = $_FILES["photo"]["error"];

    if ($file_error === UPLOAD_ERR_OK) {
        // Comprobar el tipo de archivo
        $allowed_types = array("image/jpeg", "image/png");
        if (in_array($file_type, $allowed_types)) {
            // Directorio de destino para guardar la imagen
            $target_dir = "uploads/";
            // Generar un nombre único para la imagen
            $target_file = $target_dir . uniqid() . "_" . $file_name;

            // Mover la imagen al directorio de destino
            if (move_uploaded_file($file_tmp, $target_file)) {
                // Actualizar la ruta de la imagen en la base de datos
                $update_photo = "UPDATE usuarios SET foto = ? WHERE id = ?";
                $stmt = $conn->prepare($update_photo);
                $stmt->bind_param("si", $target_file, $user_id);
                $stmt->execute();

                // Redireccionar a la página mostrardatos.php para reflejar los cambios
                header("Location: mostrardatos.php");
                exit;
            } else {
                echo "<script>alert('Hubo un error al subir la imagen.');</script>";
            }
        } else {
            echo "<script>alert('El tipo de archivo no es válido. Solo se permiten archivos JPEG y PNG.');</script>";
        }
    } elseif ($file_error === UPLOAD_ERR_NO_FILE) {
        // No se seleccionó ninguna imagen, se mantiene la imagen actual en la base de datos
    } else {
        echo "<script>alert('Hubo un error al subir la imagen. Código de error: $file_error');</script>";
    }
}

//Vista de admin
$user_role = $user['rol'];

if ($user_role === "administrador") {
    $sql = "SELECT * FROM usuarios";
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $all_users = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

    if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['modify_user_id'])) {
        $modify_user_id = $_POST['modify_user_id'];
        $new_role = $_POST['new_role'];

        $update_role = "UPDATE usuarios SET rol = ? WHERE id = ?";
        $stmt = $conn->prepare($update_role);
        $stmt->bind_param("si", $new_role, $modify_user_id);
        $stmt->execute();

        header("Location: mostrardatos.php");
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['delete_user_id'])) {
        $delete_user_id = $_POST['delete_user_id'];

        $delete_user = "DELETE FROM usuarios WHERE id = ?";
        $stmt = $conn->prepare($delete_user);
        $stmt->bind_param("i", $delete_user_id);
        $stmt->execute();

        header("Location: mostrardatos.php");
    }
}

$stmt->close();
$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>FilmFlow-Mostrar Datos</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav>
        <a href="mainPage.php"><img src="./img/captura2-removebg-preview.png" alt="Logo" width="200px" /></a>
    </nav>
    <img class="background_login" src="./img/background_php.jpg" alt="background" />
    <main>
        <div class="user_data">
            <h1>Datos de Usuario</h1>
            <form action="mostrardatos.php" method="post" enctype="multipart/form-data">
                <img src="<?php echo $user['foto']; ?>" alt="Foto de perfil actual" width="150" /><br>
                <label for="photo">Nueva foto de perfil (opcional):</label><br>
                <input type="file" id="photo" name="photo"><br>
                
                <label for="fname">Nombre:</label><br>
                <input type="text" id="fname" name="fname" value="<?php echo $user['nombre']; ?>" required><br>
                    
                <label for="lname">Apellidos:</label><br>
                <input type="text" id="lname" name="lname" value="<?php echo $user['apellidos']; ?>" required><br>

                <label for="nickname">Nombre de usuario:</label><br>
                <input type="text" id="nickname" name="nickname" value="<?php echo $user['nickname']; ?>" required><br>
                
                <label for="email">Correo electrónico:</label><br>
                <input type="email" id="email" name="email" value="<?php echo $user['email']; ?>" required><br>

                <label for="current_password">Contraseña actual:</label><br>
                <input type="password" id="current_password" name="current_password" required><br>

                <label for="new_password">Nueva contraseña (opcional):</label><br>
                <input type="password" id="new_password" name="new_password"><br>

                <label for="confirm_new_password">Confirmar nueva contraseña (opcional):</label><br>
                <input type="password" id="confirm_new_password" name="confirm_new_password"><br>
                
                <input class="submit" type="submit" value="Actualizar Datos">
            </form> 
        </div>

        <?php if ($user_role === "administrador"): ?>
         <div class="admin_section">
        <h2>Usuarios registrados</h2>
        <p></p>
        <?php foreach ($all_users as $u): ?>
            <?php if ($u['rol'] !== 'administrador'): ?> 
            <div class="user">
            <img src="<?php echo $u['foto']; ?>" alt="Foto de perfil" width="150"><br> <!-- Muestra la foto de perfil -->
                <p></p>
                <p>Nombre: <?php echo $u['nombre']; ?></p>
                <p>Apellidos <?php echo $u['apellidos']; ?></p>
                <p>Nombre de usuario: <?php echo $u['nickname']; ?></p>
                <p>Email: <?php echo $u['email']; ?></p>
                <p>Rol: <?php echo $u['rol']; ?></p>
                <form action="mostrardatos.php" method="post">
                    <input type="hidden" name="modify_user_id" value="<?php echo $u['id']; ?>">
                    <select name="new_role">
                        <option value="usuario">Usuario</option>
                        <option value="administrador">Administrador</option>
                    </select>
                    <input type="submit" value="Cambiar rol">
                </form>
                <form action="mostrardatos.php" method="post">
                    <input type="hidden" name="delete_user_id" value="<?php echo $u['id']; ?>">
                    <input type="submit" value="Eliminar usuario">
                </form>
                <p></p>
                <p></p>
            </div>
            <?php endif; ?>
        <?php endforeach; ?>
    </div>
<?php endif; ?>
    </main>
    <div class="m"></div>
    <script src="app.js"></script>
</body>
</html>
