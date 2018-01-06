<?php
    // Suppression affichage messages erreurs
    ini_set('display_errors','on');
    ini_set('display_startup_errors','on');
    error_reporting(E_ALL);

    // 0. Fonction permettant de traiter les éléments du formulaire (-> éviter injections SQL)
    include "traiterSaisies.php";

    // 1. Chargement des variables de connexion
    include "varConnexion.php";

    // Gestion des erreurs de saisie
    $erreur = false;

    //if (isset($_POST) AND count($_POST)) {
    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        // Gestion de la valeur de Submit
        $Submit = isset($_POST['Submit']) ? $_POST['Submit'] : '';

    /*
    ----
    Écrire CI-DESSOUS le traitement permettant d’enregistrer les données transmises par le formulaire
    ----
    */
    // Connection à la base de donnée
    try {
      $pdo = new PDO($server, $userBD, $passBD);
    } catch (PDOException $e) {
        print "Erreur !: " . $e->getMessage() . "<br/>";
    }

    // Variables
    $PseudoEtu = htmlspecialchars($_POST["PseudoEtu"]);
    $Password = htmlspecialchars($_POST["Password"]);
    $Email = htmlspecialchars($_POST["Email"]);

    // Réquête préparée INSERT INTO ETUDIANT
    try {
      $requete = $pdo->prepare("INSERT INTO ETUDIANT (PseudoEtu, Password, Email) VALUES (:PseudoEtu, :Password, :Email)");
      $requete->execute(array('PseudoEtu' => $PseudoEtu ,
                              'Password' => $Password ,
                              'Email' => $Email
                              )
                        );


    } catch (Exception $e) {
      print "la requête ne fonctionne pas";
      // Saisies invalides
      $erreur = true;
      $errSaisies =  "Erreur, la saisie est obligatoire !";
    }


    // 9. Redirige vers la page de liste des chauffeurs après l'enregistrement
    header("Location:TODO_list.html");
    exit();

        //if (!$erreur) {
          //header("Location:creerChauffeur.php?saved=".$id);
          //exit();
        //}

    }   // Fin du if ($_SERVER["REQUEST_METHOD"] == "POST")

?>

<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="utf-8">
    <title>DOOMI - Inscription</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link href="assets/style/style.css" rel="stylesheet">
  </head>

  <body>
    <div class="home">

      <h1>DOOMMI</h1>
      <p>Tous les champs sont obligatoires !</p>

      <p>&nbsp;</p>

<?php
    if (isset($_GET['saved']) and $_GET['saved']) {
?>
        <!-- Main hero unit for a primary marketing message or call to action -->
        <div class="hero-unit">
            <h1>Nouveau membe enregistré !</h1>
        </div>
        <p>&nbsp;</p>
<?php
    }   // Fin du if
?>
    <form method="post" action="inscription.php" class="form-horizontal">

        <div class="control-group">
            <label class="control-label" for="PseudoEtu">Pseudo</label>
            <div class="controls">
                <input type="text" name="PseudoEtu" id="PseudoEtu" value="" placeholder="" autofocus="autofocus" />
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="Password">Password</label>
            <div class="controls">
                <input type="password" name="Password" id="Password" value="" placeholder="" />
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="Email">Email</label>
            <div class="controls">
                <input type="text" name="Email" id="Email" value="" placeholder="" />
            </div>
        </div>

        <div class="control-group">
            <div class="controls">
        <?php
          // CTRL de l'existence des saisies
          if ($erreur) {
              echo ($errSaisies);
          }
          else {
              $errSaisies = "";
              echo ($errSaisies);
          }
        ?>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <input type="submit" name="Submit" value="Valider" class="btn btn-primary" />
            </div>
        </div>

    </form>

      <!--<p>&nbsp;</p>-->

      <hr />

      <footer>
        <p>&copy; DOOMI 2018</p>
      </footer>

    </div> <!-- /container -->
  </body>
</html>
