# -> Gérer complètement le focus
# -> Gérer une initiative égale entre plusieurs participants. Dans ce cas : le joueur relance.

# -> Définir les méthodes publiques et privées des classes

# -> Empêcher une saisie inférieur à 1 ou supérieure à 20
# -> Ajouter une correspondance entre un statut et sa description via une nouvelle classe Etat

# -> Gérer différents types de participants (Joueur, PNJ, Monstre) via l'héritage
# -> Lorsque un personnage atteint 0 PV, le déclaré mort (uniquement si c'est un monstre)

# -> Définir Etat commme un tableau contenant des états car un personnage peut en subir plusieurs à la fois.

##########################################################
# Gestion automatisée des combats pour une partie de D&D #
# Version du programme : 0.2                             #
##########################################################

# ----------------------------------------------------------------------

############################
# Appel des Classes        #
############################

require_relative 'Classes/Participants.rb'
require_relative 'Classes/Personnage.rb'

# ----------------------------------------------------------------------

# ----------------------------------------------------------------------

############################
# Exécution du programme   #
############################

# ----------------------------------------------------------------------

###############################################
# Initialisation des participants au combat   #
###############################################


# -- Création d'un tableau vide de participants
participants = Participants.new()

# -- Création de mes participants, puis définition de leurs variables d'instance

aral = Personnage.new("Aral")
aral.setCarac("Aral", 0, 100, 100, false, "")
participants.ajoutParticipants(aral)
barash = Personnage.new("Barash")
barash.setCarac("Barash", 0, 100, 100,false, "")
participants.ajoutParticipants(barash)
bendak = Personnage.new("Bendak")
bendak.setCarac("Bendak", 0, 100, 100, false, "")
participants.ajoutParticipants(bendak)
drake = Personnage.new("Drake")
drake.setCarac("Drake", 0, 100, 100, false, "")
participants.ajoutParticipants(drake)
erazal = Personnage.new("Erazal")
erazal.setCarac("Erazal", 0, 100, 100, false, "")
participants.ajoutParticipants(erazal)
himoreal = Personnage.new("Himoreal")
himoreal.setCarac("Himoreal", 0, 100, 100, false, "")
participants.ajoutParticipants(himoreal)

nombre_participants = participants.nombreParticipants

########################################################################################
# Saisie de l'initiative des joueurs et ajout des personnages (alliés, monstres ...)   #
########################################################################################

puts ""
puts "|--------------------------------------------|"
puts "|------| Version du programme : V 0.2 |------|"
puts "|------| Développé en Ruby : V 2.5.1  |------|"
puts "|--------------------------------------------|"

puts ""
puts ""

puts "                                                 ,--,  ,.-.               "
puts "                       ,                   \,       '-,-`,'-.' | ._       "
puts "                      /|           \    ,   |\         }  )/  / `-,',     "
puts "                      [ ,          |\  /|   | |        /  \|  |/`  ,`     "
puts "                      | |       ,.`  `,` `, | |  _,...(   (      .',      "
puts "                      \  \  __ ,-` `  ,  , `/ |,'      Y     (   /_L\     "
puts "                       \  \_\,``,   ` , ,  /  |         )         _,/     "
puts "                        \  '  `  ,_ _`_,-,<._.<        /         /        "
puts "                         ', `>.,`  `  `   ,., |_      |         /         "
puts "                           \/`  `,   `   ,`  | /__,.-`    _,   `\         "
puts "                       -,-..\  _  \  `  /  ,  / `._) _,-\`       \        "
puts "                        \_,,.) /\    ` /  / ) (-,, ``    ,        |       "
puts "                       ,` )  | \_\       '-`  |  `(               \       "
puts "                      /  /```(   , --, ,' \   |`<`    ,            |      "
puts "                     /  /_,--`\   <\  V /> ,` )<_/)  | \      _____)      "
puts "               ,-, ,`   `   (_,\ \    |   /) / __/  /   `----`            "
puts "              (-, \           ) \ ('_.-._)/ /,`    /                      "
puts "              | /  `          `/ \\ V   V, /`     /                       "
puts "           ,--\(        ,     <_/`\\     ||      /                        "
puts "          (   ,``-     \/|         \-A.A-`|     /                         "
puts "         ,>,_ )_,..(    )\          -,,_-`  _--`                          "
puts "        (_ \|`   _,/_  /  \_            ,--`                              "
puts "         \( `   <.,../`     `-.._   _,-`                                  "
puts "                                                                          "
puts "                                                                          "

puts "--| Début du jeu |--"
puts "--| Initialisation des joueurs de base |--"
puts ""

# -- Donner une initiative de départ à tous les joueurs initiaux --
liste_participants = participants.getParticipants()
liste_participants.each do |participant|
    puts "Saisissez l'initiative de #{participant.nom.upcase}"
    initiative_depart = gets.chomp.to_i
    if initiative_depart >= 1 && initiative_depart <= 20
      participant.setInit(initiative_depart)
    else
      puts ""
      puts "ATTENTION : l'initiative de #{participant.nom.upcase} n'est pas comprise entre 0 et 20 !"
      puts ""
      participant.setInit(999)
    end
end

participants.triParticipantsParInit

ajouter_participant = ""

# -- Ajout des joueurs supplémentaires pour initier le combat (typiquement des monstres ou des PNJ alliés) --
while ajouter_participant != "Non" || ajouter_participant == "N"

  puts "--| Ajouter un participant ? : 1. (O)ui, 2. (N)on"
  ajouter_participant = gets.chomp.to_s.capitalize

  if ajouter_participant == "Oui" || ajouter_participant == "O"
    puts "->  Sélectionner le nom du nouveau personnage"
    reponse_nom = gets.chomp.to_s.capitalize
    puts ""
    nouveau_participant = Personnage.new(reponse_nom)
    puts "-> Sélectionnez l'initiative de #{nouveau_participant.nom.upcase}"
    nouveau_participant_init = gets.chomp.to_i
    if nouveau_participant_init < 1 || nouveau_participant_init > 20
      puts ""
      puts "ATTENTION : l'initiative de #{nouveau_participant.nom.upcase} n'est pas comprise entre 0 et 20 !"
      puts ""
    end
    puts "-> Sélectionnez les points de vie de #{nouveau_participant.nom.upcase}"
    nouveau_participant_pv = gets.chomp.to_i
    #puts "-> Sélectionnez les points de vie maximum de #{nouveau_participant.nom}"
    #nouveau_participant_pv_max = gets.chomp.to_i
    nouveau_participant_pv_max = nouveau_participant_pv
    nouveau_participant.setCarac(nouveau_participant.nom, nouveau_participant_init, nouveau_participant_pv_max, nouveau_participant_pv, false, "")
    participants.ajoutParticipants(nouveau_participant)
    participants.triParticipantsParInit

  elsif ajouter_participant == "Non" || ajouter_participant == "N"
    ajouter_participant = "Non"
  end
end

ajuster_initiative = ""

# -- Recalibrer l'initiative en cas d'égalité --
while ajuster_initiative != "Non" || ajuster_initiative == "N"
  participants.listerParticipants()
  puts ""
  puts "--| Faut-il ajuster l'initiative ? : 1. (O)ui, 2. (N)on"

  ajuster_initiative = gets.chomp.to_s.capitalize

  if ajuster_initiative == "Oui" || ajuster_initiative == "O"
    puts "->  Sélectionner le nom du personnage"
    ajuster_initiative_nom = gets.chomp.to_s
    puts "-> Sélectionner la nouvelle initiative de #{ajuster_initiative_nom} : "
    nouvelle_init = gets.chomp.to_i
    ajuster_initiative_nom = participants.recupNom(ajuster_initiative_nom)
    ajuster_initiative_nom.setInit(nouvelle_init)
    participants.triParticipantsParInit

  elsif ajuster_initiative == "Non" || ajuster_initiative == "N"
    ajuster_initiative = "Non"
  end
end

nombre_participants = participants.nombreParticipants

# -- Calage du focus sur le personnage qui a l'initiative la plus haute --
max_initiative = participants.maxInit()
participants.initFocus(max_initiative)

commande = ""
compteur = 0
numero_tour = 0

#################################################
# Interface utilisateur principale du programme #
#################################################

puts ""
puts ""
puts ""
puts "-------------------------------------------------------------------------"
puts "       .-._                                                   _,-,       "
puts "        `._`-._                                           _,-'_,'        "
puts "            `._ `-._                                   _,-' _,'          "
puts "               `._  `-._        __.-----.__        _,-'  _,'             "
puts "                  `._   `#==='''           '''===#'   _,'                "
puts "                     `._/)  ._               _.  (\_,'                   "
puts "                      )*'     **.__     __.**     '*(                    "
puts "                      #  .==..__  ''   ''  __..==,  #                    "
puts "                      #   `''._(_).       .(_)_.''' #                    "
puts "-------------------------------------------------------------------------"
puts ""
puts ""
puts ""

while commande != "Quitter" && commande != "Q"

  puts "--| COMMANDES :  1. '(L)ister', 2. '(C)arac' 3. '(A)jouter', 4. '(J)ouer', 5. '(Q)uitter' |--"
  puts ""

  commande = gets.chomp.to_s.capitalize

  if commande == "Lister" || commande == "L"
    participants.listerParticipants()

  elsif commande == "Ajouter" || commande == "A"
    puts "->  Sélectionner le nom du nouveau personnage"
    reponse_nom = gets.chomp.to_s
    puts ""
    nouveau_participant = Personnage.new(reponse_nom)
    puts "-> Sélectionnez l'initiative de #{nouveau_participant.nom}"
    nouveau_participant_init = gets.chomp.to_i
    puts "-> Sélectionnez les points de vie de #{nouveau_participant.nom}"
    nouveau_participant_pv = gets.chomp.to_i
    puts "-> Sélectionnez les points de vie maximum de #{nouveau_participant.nom}"
    nouveau_participant_pv_max = gets.chomp.to_i

    nouveau_participant.setCarac(nouveau_participant.nom, nouveau_participant_init, nouveau_participant_pv_max, nouveau_participant_pv, false, "")
    participants.ajoutParticipants(nouveau_participant)
    participants.triParticipantsParInit

    nombre_participants = participants.nombreParticipants

  elsif commande == "Carac" || commande == "C"
    puts "-> Sélectionnnez le personnage pour afficher ses caractéristiques : --|"
    personnage_nom = gets.chomp.to_s.capitalize
    if participants.presenceNom(personnage_nom) == true
      personnage_nom = participants.recupNom(personnage_nom)
      personnage_nom.afficheCarac()
    else
      puts ""
      puts "! Ce participant n'existe pas !"
      puts ""
    end

  elsif commande == "Jouer" || commande == "J"
    puts "Numero du tour : <#{numero_tour}>"
    puts "Nombre de participants : #{nombre_participants}"
    puts "Compteur : #{compteur}"
    participants.afficheFocusParticipants(compteur)
    action = ""
    while action != "Retour" && action != "R"
      puts "--| ACTIONS : 1. '(S)uivant', 2. '(F)ocus', 3. '(L)ister', 4. '(A)ttaque', 5. '(H)eal', 6. '(E)tat', 7. '(M)ort', 8. '(R)etour' |--"
      action = gets.chomp.to_s.capitalize

      if action == "Suivant" || action == "S"
        numero_tour += 1
        compteur += 1
        puts "Numero du tour : <#{numero_tour}>"
        puts "Nombre de participants : #{nombre_participants}"
        puts "Compteur : #{compteur}"
        participants.afficheFocusParticipants(compteur)
        if compteur == nombre_participants-1.to_i
          compteur = -1
        end


      elsif action == "Focus" || action == "F"
        puts "-> Saisissez le participant à qui donner le focus : "
        personnage_nom = gets.chomp.to_s.capitalize
        if participants.presenceNom(personnage_nom) == true
          participants.donnerFocus(personnage_nom)
        else
          puts ""
          puts "! Ce participant n'existe pas !"
          puts ""
        end

      elsif action == "Lister" || action == "L"
        participants.afficheFocusDepartParticipants()

      elsif action == "Attaque" || action == "A"
        puts "-> Sélectionnnez le personnage attaqué : "
        personnage_nom = gets.chomp.to_s.capitalize

        if participants.presenceNom(personnage_nom) == true
            personnage_nom = participants.recupNom(personnage_nom)
            puts "-> Entrez le nombre de points de vie retirés : "
            pv_retrait = gets.chomp.to_i
            personnage_nom.retraitPV(pv_retrait)
        else
          puts ""
          puts "! Ce participant n'existe pas !"
          puts ""
        end

      elsif action == "Heal" || action == "H"
        puts "-> Sélectionnnez le personnage auquel ajouter des PV : "
        personnage_nom = gets.chomp.to_s.capitalize

        if participants.presenceNom(personnage_nom) == true
            personnage_nom = participants.recupNom(personnage_nom)
            puts "-> Entrez le nombre de points de vie ajoutés : "
            pv_ajout = gets.chomp.to_i
            personnage_nom.ajoutPV(pv_ajout)
        else
          puts ""
          puts "! Ce participant n'existe pas !"
          puts ""
        end

      elsif action == "Etat" || action == "E"
        puts "-> Sélectionnnez le personnage auquel affecter un état (brule, gel, paralysie ...) : "
        personnage_nom = gets.chomp.to_s.capitalize

        if participants.presenceNom(personnage_nom) == true
            personnage_nom = participants.recupNom(personnage_nom)
            puts "-> Entrez l'état : "
            etat = gets.chomp.to_s.upcase
            personnage_nom.setEtat(etat)
        else
          puts ""
          puts "! Ce participant n'existe pas !"
          puts ""
        end

      elsif action == "Mort" || action == "M"
        puts "-> Entrez le personnage déclaré mort : "
        personnage_nom = gets.chomp.to_s.capitalize
        if participants.presenceNom(personnage_nom) == true
          participants.supprimeParticipant(personnage_nom)
          nombre_participants = participants.nombreParticipants
          participants.listerParticipants()
        else
          puts ""
          puts "! Ce participant n'existe pas !"
          puts ""
        end
      end
    end
  end
end
