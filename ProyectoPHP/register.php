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
    $name = $_POST['fname'];
    $surname = $_POST['lname'];
    $nickname = $_POST['nickname'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $role = "Usuario"; // por defecto
    $target_dir = "uploads/";
    $target_file = $target_dir . basename($_FILES["photo"]["name"]);

    // Comprobar si existe un usuario con el nickname introducido
    $check = "SELECT * FROM usuarios WHERE nickname = '$nickname'";
    $res = $conn->query($check);
    if($res->num_rows > 0) {
        echo "<script>alert('LOS DATOS YA ESTÁN EN USO POR OTRO USUARIO');</script>";
    } else {
        // cifrar la contraseña
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // subir foto
        if (move_uploaded_file($_FILES["photo"]["tmp_name"], $target_file)) {
            echo "La imagen ". htmlspecialchars(basename($_FILES["photo"]["name"])). " ha sido subida.";
        } else {
            echo "Hubo un error subiendo tu foto.";
        }

        //se insertan los datos del usuario en la bbdd
        $sql = "INSERT INTO usuarios (nombre, apellidos, nickname, email, contrasena, foto, rol)
                VALUES ('$name', '$surname', '$nickname', '$email', '$hashed_password', '$target_file', '$role')";

        if ($conn->query($sql) === TRUE) {
            echo "Registro exitoso";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }

        if (!$res) {
            // Error al insertar los datos
            echo "Error al insertar los datos: " . mysqli_error($conn);
        } else {
            // Redirigir al usuario a la página de login
            header("Location: login.php");
        }
    }

    $conn->close();
}

?>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FilmFlow-Register Page</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav>
        <a href="index.php"><img src="./img/captura2-removebg-preview.png" alt="Logo" width="200px" /></a>
      </nav>
      <img class="background" src="./img/background_php.jpg" alt="background" />
      <main>
        <div class="user_register">
            <h1>Registro</h1>
            <form action="register.php" method="post" enctype="multipart/form-data">

                <label for="photo">Foto de perfil:</label><br>
                <input type="file" id="photo" name="photo" required><br>
                
                <label for="fname">Nombre:</label><br>
                <input type="text" id="fname" name="fname" required><br>
                    
                <label for="lname">Apellido:</label><br>
                <input type="text" id="lname" name="lname" required><br>

                <label for="nickname">Nombre de usuario:</label><br>
                <input type="text" id="nickname" name="nickname" required><br>
                
                <label for="email">Correo electrónico:</label><br>
                <input type="email" id="email" name="email" required><br>
                
                <label for="password">Contraseña:</label><br>
                <input type="password" id="password" name="password" required><br>
                
                <input class="submit" type="submit" value="Registrarse">
            </form> 
            <p>¿Ya tienes una cuenta? <span><a href="login.php">Iniciar Sesión</a></span></p>
        </div>
      </main>
      <div class="m"></div>
    <script src="app.js"></script>
</body>
</html>