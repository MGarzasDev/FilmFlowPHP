<?php
// Conexión a la base de datos
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "FilmFlowDB";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Consulta para obtener los datos de la película
$sql = "SELECT * FROM peliculas WHERE titulo = 'Deadpool 2'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $pelicula = $result->fetch_assoc();
} else {
    echo "No se encontró la película.";
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $pelicula['titulo']; ?></title>
    <link rel="stylesheet" href="./style.css">
</head>
<body>
<nav>
<a href="mainPage.php"><img src="./img/captura2-removebg-preview.png" alt="Logo" width="200px" /></a>
      <ul>
        <li class="register"><a href="logout.php">Cerrar Sesión</a></li>
        <li class="user_profile"><a href="mostrardatos.php"><img src="./img/user.png" alt=""></a></li>
      </ul>
    </nav>
    <img class="background" src="./img/background_php.jpg" alt="background" />
    <main>
        <div class = "trailer">
        <h1 class = "titulo"><?php echo $pelicula['titulo']; ?></h1>
        <iframe width="800" height="400" src="https://www.youtube.com/embed/U6VMFwS2mPk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>         </div>
        <div class="movie_container">
        <img src="./img/comedia7.jpg" alt="" width="200px">
        <div class="movie_info">
        <h1><?php echo $pelicula['titulo']; ?></h1>
        <p><?php echo $pelicula['sinopsis']; ?></p>
        <p><span>Año:</span> <?php echo $pelicula['anio']; ?></p>
        <p><span>Duracion:</span> <?php echo $pelicula['duracion']; ?> minutos</p>
        <p><span>Genero:</span> <?php echo $pelicula['genero']; ?></p>
        <button><a href="troleo.html">Ver pelicula</a></button>
        </div>
        </div>
    </main>
    <button id="scrollToTopButton"><img src="./img/icons8-arriba-30.png" alt=""></button>
    <script src="app2.js"></script>   
</body>
</html>
