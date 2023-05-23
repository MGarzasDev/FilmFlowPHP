DROP DATABASE IF EXISTS FilmFlowDB;

CREATE DATABASE IF NOT EXISTS FilmFlowDB;

USE FilmFlowDB;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    nickname VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contrasena CHAR(64) NOT NULL,  -- SHA256
    foto LONGBLOB,
    rol ENUM('usuario', 'administrador') NOT NULL DEFAULT 'usuario'
);

CREATE TABLE IF NOT EXISTS peliculas (	
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    sinopsis TEXT,
    anio YEAR,
    duracion INT,  -- en minutos
    genero ENUM('Acción', 'Terror', 'Comedia', 'Animación') NOT NULL
);

SELECT * FROM usuarios;

select * from peliculas;

UPDATE usuarios set rol = 'administrador' where nickname = 'Admin' and email = 'admin@gmail.com';

-- INSERTS

-- Accion
INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Fast & Furious X', 
    'Durante numerosas misiones más que imposibles, Dom Toretto y su familia han sido capaces de ser más listos, de tener más valor y de ir más rápido que cualquier enemigo que se cruzara con ellos. Pero ahora tendrán que enfrentarse al oponente más letal que jamás hayan conocido: Un terrible peligro que resurge del pasado, que se mueve por una sangrienta sed de venganza y que está dispuesto a destrozar a la familia y destruir para siempre todo lo que a Dom le importa.', 
    2023, 
    130, 
    'Acción'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'John Wick 4', 
    'John Wick, legendario asesino retirado, vuelve de nuevo a la acción impulsado por una incontrolable búsqueda de venganza. Al tener que luchar contra asesinos sedientos de sangre que le persiguen, John tendrá que llevar sus habilidades al límite si quiere salir esta vez con vida', 
    2023, 
    169, 
    'Acción'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Shang-Chi y la leyenda de los Diez Anillos', 
    'Shang-Chi (Simu Liu) es un chico que trata de huir de su pasado y que se ha construido una nueva vida y una nueva identidad en Estados Unidos. Pronto veremos que no lo ha hecho tan bien, pues su padre, Xu Wenwu (Tony Leung) va tras él y su hermana menor, Xialing (Meng’er Zhang). Encontrarlos y traerlos de vuelta a casa no será algo difícil ya que tiene el poder de los diez anillos, arma que pretende usar para traer de vuelta a su mujer, ya sea con la ayuda de sus hijos o sin ella. El regreso a casa de Shang-Chi se convertirá en una carrera a contrarreloj para salvar el mundo.', 
    2021, 
    132, 
    'Acción'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Avatar: El sentido del agua', 
    'Más de una década después de los acontecimientos de Avatar, los Na vi Jake Sully, Neytiri y sus hijos viven en paz en los bosques de Pandora hasta que regresan los hombres del cielo. Entonces comienzan los problemas que persiguen sin descanso a la familia Sully, que decide hacer un gran sacrificio para mantener a su pueblo a salvo y seguir ellos con vida.', 
    2022, 
    192, 
    'Acción'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Creed III', 
    'Después de dominar el mundo del boxeo, Adonis Creed ha progresado tanto en su carrera como en su vida familiar. Cuando Damian (Jonathan Majors), un amigo de la infancia y antiguo prodigio del boxeo, reaparece después de cumplir una larga condena en prisión, Adonis Creed quiere demostrar que merece una oportunidad en el ring. El enfrentamiento entre estos antiguos amigos es algo más que una simple pelea. Para ajustar cuentas, Adonis debe arriesgar su futuro para enfrentarse a Damian, un boxeador que no tiene nada que perder. Tercera entrega de la revitalizada franquicia Rocky para MGM, en la que Jordan retoma su papel de "Adonis Creed". ', 
    2023, 
    116, 
    'Acción'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Black Adam', 
    'Casi 5.000 años después de haber sido dotado de los poderes omnipotentes de los antiguos dioses, Black Adam (Johnson) es liberado de su tumba terrenal, listo para desatar su forma única de justicia en el mundo moderno.', 
    2022, 
    125, 
    'Acción'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Venom: Habrá matanza', 
    'Eddie Brock (Tom Hardy) y su simbionte Venom todavía están intentando descubrir cómo vivir juntos cuando un preso que está en el corredor de la muerte (Woody Harrelson) se infecta con un simbionte propio. ', 
    2021, 
    97, 
    'Acción'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Rogue', 
    'Rogue es la historia de una pequeña unidad mercenaria de soldados que han sido contratados por el gobernador de un país africano para rescatar a su hija que ha sido secuestrada por una organización terrorista.', 
    2020, 
    106, 
    'Acción'
);

-- Animación

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Super Mario Bros: La película', 
    'Mientras trabajan en una avería subterránea, los fontaneros de Brooklyn, Mario y su hermano Luigi, viajan por una misteriosa tubería hasta un nuevo mundo mágico. Pero, cuando los hermanos se separan, Mario deberá emprender una épica misión para encontrar a Luigi. Con la ayuda del champiñón local Toad y unas cuantas nociones de combate de la guerrera líder del Reino Champiñón, la princesa Peach, Mario descubre todo el poder que alberga en su interior.', 
    2023, 
    92, 
    'Animación'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'El gato con botas: El último deseo', 
    'El Gato con Botas descubre que su pasión por la aventura le ha pasado factura: ha consumido ocho de sus nueve vidas, por ello emprende un viaje épico para encontrar el mítico Último Deseo y restaurar sus nueve vidas... ', 
    2022, 
    100, 
    'Animación'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Jujutsu Kaisen 0: La película', 
    'Yuta Okkotsu es un chico de instituto bastante nervioso con un grave problema: Su amigo Rika se ha convertido en un "Curse" y no le deja a solas. Ya que Rika no es un Curse ordinario, capta la atención de Satoru Gojo, un profesor del Instituto "Jujutsu", donde los exorcistas aprenden a combatir a los Curse. Gojo convence a Yuta para enrolarse en al academia... ¿Podrá aprender Yuta a controlar al Curse que le atormenta?. Precuela de la serie anime "Jujutsu Kaisen".', 
    2021, 
    105, 
    'Animación'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Dragon Ball Super: Super Hero', 
    'Son Goku destruyó en su momento a la Patrulla Roja. Ahora, ciertos individuos han decidido continuar con su legado y han creado a los androides definitivos: Gamma 1 y Gamma 2. Estos dos androides se autoproclaman "superhéroes" y deciden atacar a Piccolo y a Gohan. ¿Cuál es el objetivo de la nueva Patrulla Roja? Ante un peligro inminente, ¡llega el momento del despertar del Superhéroe!', 
    2022, 
    100, 
    'Animación'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'One Piece Film Red', 
    'Uta, la cantante número uno del mundo, se dispone a dar su primer concierto en directo frente a un público formado por piratas, marines y toda clase de fans. Uta está considerada la cantante más querida de todo el mundo. A pesar de que siempre ha ocultado su identidad, se dice que su voz al cantar es tan maravillosa que parece proceder de “otra dimensión”. Ahora, se celebrará un concierto en directo en el que aparecerá en persona por primera vez frente al público. La tan esperada voz que todo el mundo quiere oír se dispone a resonar mientras multitud de coloridos piratas, marines que no le quitan el ojo de encima, los Piratas de Sombreros de Paja de Luffy, quien se siente atraído por la voz de Uta sin saber nada, y toda clase de fans de Uta llenan el lugar. La historia arranca con la impactante revelación de que Uta es la hija de Shanks.', 
    2022, 
    115, 
    'Animación'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Fate/stay night: Heavens Feel III. Spring Song', 
    'Angra Mainyu ha poseído con éxito su nave Sakura Matou. Depende de Rin, Shirou y Rider limpiar el grial o será el fin del mundo y la hechicería como todos la conocemos. Tercera película de la trilogía Heavens Feel de la saga Fate/stay night.', 
    2020, 
    120, 
    'Animación'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'La princesa Mononoke', 
    'Con el fin de curar la herida que le ha causado un jabalí enloquecido, el joven Ashitaka sale en busca del dios Ciervo, pues sólo él puede liberarlo del sortilegio. A lo largo de su periplo descubre cómo los animales del bosque luchan contra hombres que están dispuestos a destruir la Naturaleza', 
    1997, 
    133, 
    'Animación'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'The End of Evangelion', 
    'Shinji Ikari, el protagonista de Neon Genesis Evangelion, debe evitar que suceda un tercer impacto que podría acabar con la vida en la tierra. Es por ello que tiene que aliarse con Misato y Rei Ayanami para detener los planes de SEELE, que quiere llevar a cabo el Proyecto de Complementación Humana.', 
    1997, 
    87, 
    'Animación'
);

-- Terror 

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'El exorcista del papa', 
    'Película sobre Gabriele Amorth, un sacerdote que ejerció como exorcista principal del Vaticano, realizando más de cien mil exorcismos a lo largo de su vida. Amorth escribió dos libros de memorias donde detalló sus experiencias luchando contra Satanás.', 
    2023, 
    103, 
    'Terror'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Halloween Kills', 
    'La noche de Halloween en la que Michael Myers regresa no ha acabado todavía. Minutos después de que Laurie Strode, su hija Karen y su nieta Allyson dejen encerrado y ardiendo a este monstruo enmascarado, Laurie se dirige rápidamente al hospital para tratar sus heridas, creyendo que todo ha terminado. Pero cuando Michael consigue liberarse, su ritual sangriento continúa. Mientras Laurie lidia con su dolor y se prepara para defenderse, sirve de inspiración para que todo Haddonfield se levante contra este monstruo imparable.', 
    2021, 
    105, 
    'Terror'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Posesión infernal: El despertar', 
    'Historia de dos hermanas separadas cuyo reencuentro se ve interrumpido por el surgimiento de demonios poseedores de carne, empujándolos a una batalla por la supervivencia mientras se enfrentan a la versión de familia más aterradora que se pueda imaginar. Secuela de la trilogía original de Evil Dead.', 
    2023, 
    97, 
    'Terror'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Scream VI', 
    'Tras los últimos asesinatos de Ghostface, los cuatro supervivientes abandonan Woodsboro para dar comienzo a un nuevo capítulo en la ciudad de Nueva York.', 
    2023, 
    123, 
    'Terror'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Winnie the Pooh: Blood and Honey', 
    'Winnie the Pooh: Blood and Honey sigue a Pooh y Piglet, que se han convertido en psicópatas después de que Christopher Robin los abandona', 
    2023, 
    84, 
    'Terror'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Terrifier 2', 
    'Después de ser resucitado por una entidad siniestra, Art the Clown regresa al condado de Miles, donde debe cazar y destruir a una adolescente y a su hermano menor en la noche de Halloween', 
    2022, 
    138, 
    'Terror'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Candyman', 
    'Desde tiempos inmemoriales, los proyectos residenciales del barrio de Cabrini Green en Chicago se han visto amenazados por la historia de un supuesto asesino en serie con un gancho por mano al que se invoca fácilmente repitiendo su nombre cinco veces frente a un espejo. Hoy, una década después de que la última torre de Cabrini fuese derruída, el artista visual Anthony McCoy (Yahya Abdul-Mateen) y su novia Brianna Cartwright (Teyonah Parris), se mudan a un apartamento de lujo de un barrio ahora irreconocible, repleto de millennials y de personas que, por lo general, desconocen su oscuro pasado.', 
    2021, 
    91, 
    'Terror'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Smile', 
    'Después de presenciar un incidente extraño y traumático que involucra a un paciente, la Dra. Rose Cotter (Sosie Bacon) comienza a experimentar sucesos aterradores que no puede explicar. A medida que un terror abrumador comienza a apoderarse de su vida, Rose debe enfrentar su inquietante pasado para poder sobrevivir y escapar de su nueva y horrible realidad.', 
    2022, 
    115, 
    'Terror'
);

-- Comedia 

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Padre no hay más que uno 2: La llegada de la suegra', 
    'Con el triunfo de la asistente virtual Conchi, Javier (Santiago Segura) se ha convertido en líder del chat de madres y todo marcha sobre ruedas. Parece tenerlo todo bajo control, pero la noticia inesperada de la llegada de un nuevo bebé lo pone todo patas arriba. Y para rematar, llegará la suegra.', 
    2020, 
    96, 
    'Comedia'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Astérix y Obélix y el reino medio', 
    'Es el año 50 A.C., la Emperatriz de China acaba de ser encarcelada tras un golpe de Estado incitado por Dang Sin Kuing, un príncipe traidor. Ayudada por Granodemaíz, el comerciante fenicio, y su fiel guardaespaldas Wang Tah, la única hija de la Emperatriz, la Princesa Fo Yong, huye a la Galia para pedir ayuda a dos valientes guerreros, Astérix y Obélix, quienes están dotados de una fuerza sobrehumana gracias a su poción mágica. Nuestros dos inseparables galos aceptan por supuesto ayudar a la Princesa a salvar a su madre y liberar a su país. Y así comienza un gran viaje y aventura rumbo a China. Pero César y su poderoso ejército, sedientos de una nueva conquista, también se dirigen hacia el Reino Medio...', 
    2023, 
    111, 
    'Comedia'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'No mires arriba', 
    'Kate Dibiasky (Jennifer Lawrence), estudiante de posgrado de Astronomía, y su profesor, el doctor Randall Mindy (Leonardo DiCaprio) hacen un descubrimiento tan asombros como terrorífico: un enorme cometa lleva un rumbo de colisión directa con la Tierra. El otro problema es... que a nadie le importa. Kate y Randall emprenden una gira mediática advertir a la humanidad que los lleva desde la indiferente presidenta Orlean (Meryl Streep) y su hijo y jefe de gabinete, Jason (Jonah Hill), a la emisión de The Daily Rip, un animado programa matinal presentado por Brie (Cate Blanchett) y Jack (Tyler Perry). Solo quedan seis meses para el impacto del cometa, pero gestionar el flujo de noticias y ganarse la atención de un público obsesionado con las redes sociales antes de que sea demasiado tarde resulta sorprendentemente cómico. ¿Pero qué es lo que hay que hacer para que el mundo mire hacia arriba?', 
    2021, 
    138, 
    'Comedia'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Jumanji: Siguiente nivel', 
    'En esta ocasión, los jugadores vuelven al juego, pero sus personajes se han intercambiado entre sí, lo que ofrece un curioso plantel: los mismos héroes con distinta apariencia. Pero, ¿dónde está el resto de la gente? Los participantes sólo tienen una opción: jugar una vez más a esta peligrosa partida para descubrir qué es realmente lo que está sucediendo.', 
    2019, 
    123, 
    'Comedia'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'El Halloween de Hubie', 
    'Pese a su devoción por el pueblo de Salem, Hubie Dubois (Sandler) reconoce que la noche de Halloween no es precisamente la más atractiva para los jóvenes desde hace unos años. En esta ocasión, no obstante, algo distinto está a punto de suceder, y sólo él podrá salvar esta mágica noche', 
    2020, 
    103, 
    'Comedia'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Érase una vez en... Hollywood', 
    'Hollywood, años 60. La estrella de un western televisivo, Rick Dalton (DiCaprio), intenta amoldarse a los cambios del medio al mismo tiempo que su doble (Pitt). La vida de Dalton está ligada completamente a Hollywood, y es vecino de la joven y prometedora actriz y modelo Sharon Tate (Robbie) que acaba de casarse con el prestigioso director Roman Polanski', 
    2019, 
    165 , 
    'Comedia'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Deadpool 2', 
    'Wade Wilson (Ryan Reynolds), mejor conocido como Deadpool, su nombre de batalla e identidad antiheroica, está de regreso con Deadpool 2 y en esta ocasión su misión será salvar a un chico llamado Russell (Julian Dennison) de las manos de un poderoso rival llamado Cable (Josh Brolin). En aras de dar cumplimiento a su tarea el antihéroe formará un grupo al cual pondrá el nombre de X-Force. Secuela de la exitosa película (recaudó más de 780 millones de dólares en todo el mundo) parodia de los superhéroes mutantes del 2016, también protagonizada por Reynolds.', 
    2018, 
    111 , 
    'Comedia'
);

INSERT INTO peliculas (titulo, sinopsis, anio, duracion, genero)
VALUES (
    'Un espía y medio', 
    'Un letal agente del la CIA (Johnson), víctima de acoso escolar en su adolescencia, vuelve a casa para asistir a una reunión de antiguos alumnos. Con la excusa de estar trabajando en un caso secreto, consigue la ayuda del que fuera el chico más popular del Instituto (Hart), que ahora es un aburrido contable y vive añorando sus años de gloria. Cuando el pobre hombre se da cuenta del embrollo en el que se está metiendo, es ya demasiado tarde, pues su nuevo amigo lo implica en tiroteos, traiciones y espionaje, lo que le obligará a jugarse el cuello en incontables ocasiones', 
    2016, 
    114 , 
    'Comedia'
);
