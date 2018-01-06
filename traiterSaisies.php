<?php 
    ////////////////////////////////////////////////////////////////////////////////////////////
    //
    //  Etudiant
    //  TP M2202
    //  prg : traiterSaisies.php
    //
    ///////////////////////////////////////////////////////////////////////////////////////////
    //
    // Contrôle que nous sommes bien en validation de formulaire:
    // Lorsque le formulaire est envoyé, la varaible $_POST est renseignée
    // sous forme de tableau avec toutes les valeurs du formulaire 
    //
    // (plus d'informations sur http://php.net/manual/fr/reserved.variables.post.php)
    //

    // 0. Fonction permettant de traiter les éléments du formulaire (-> éviter injections SQL)
    function chargerSaisies($saisie) {
        $saisie = trim($saisie);
        $saisie = stripslashes($saisie);
        $saisie = htmlentities($saisie);
        return $saisie;
    }

?>