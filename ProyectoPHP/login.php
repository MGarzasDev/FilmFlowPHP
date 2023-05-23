<?php
session_name("login");
session_start();

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "FilmFlowDB";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Comprobar conexión
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    //Asignamos los campos del formulario
    $email_or_nickname = $_POST['email_or_nickname'];
    $password = $_POST['password'];
    //Comprobamos si los datos introducidos existen en la bbdd
    $sql = "SELECT * FROM usuarios WHERE email = ? OR nickname = ? LIMIT 1";
    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("ss", $email_or_nickname, $email_or_nickname);

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                $user = $result->fetch_assoc();
                if (password_verify($password, $user['contrasena'])) {
                    // La contraseña es correcta, puedes iniciar la sesión y redirigir al usuario
                    session_start();
                    $_SESSION['user_id'] = $user['id'];
                    $_SESSION['user_nickname'] = $user['nickname'];
                    $_SESSION['user_email'] = $user['email'];
                    $_SESSION['user_role'] = $user['rol'];
                    header("Location: mainPage.php");
                    exit;
                } else {
                    echo "<script>alert('La contraseña proporcionada es incorrecta')</script>";
                }
            } else {
                echo "<script>alert('No existe una cuenta con ese correo electrónico o nombre de usuario')</script>";
            }
        } else {
            echo "Algo salió mal. Por favor, inténtalo de nuevo más tarde.";
        }
    }

   
    $stmt->close();
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FilmFlow-Login Page</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav>
        <a href="index.php"><img src="./img/captura2-removebg-preview.png" alt="Logo" width="200px" /></a>
      </nav>
      <img class="background" src="./img/background_php.jpg" alt="background" />
      <main>
        <div class="user_login">
            <h1>Inicar Sesión</h1>
            <form action="login.php" method="post" enctype="multipart/form-data">
    
                <label for="email_or_nickname">Correo electrónico/Nombre de usuario:</label><br>
                <input type="text" id="email_or_nickname" name="email_or_nickname" required><br>
                
                <label for="password">Contraseña:</label><br>
                <input type="password" id="password" name="password" required><br>
                
                <input class="submit" type="submit" value="Inicar Sesión">
            </form> 
            <p>¿No tienes cuenta? <span><a href="register.php">Registrarse</a></span></p>
        </div>
      </main>
      <div class="m"></div>
    <script src="app.js"></script>
</body>
</html>