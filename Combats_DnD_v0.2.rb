# -> Gérer complètement le focus
# -> Gérer une initiative égale entre plusieurs participants. Dans ce cas : le joueur relance.

# -> Définir les méthodes publiques et privées des classes

# -> Empêcher une saisie inférieur à 1 ou supérieure à 20
# -> Ajouter une correspondance entre un statut et sa description via une nouvelle classe Etat

# -> Gérer différents types de participants (Joueur, PNJ, Monstre) via l'héritage
# -> Lorsque un personnage atteint 0 PV, le déclaré mort (uniquement si c'est un monstre)

##########################################################
# Gestion automatisée des combats pour une partie de D&D #
# Version du programme : 0.2                             #
##########################################################

# ----------------------------------------------------------------------

#######################
# Classe Participants #
#######################

class Participants

# ----------------------------------------------------------------------

  #######################################################################
  # Gestion générale des participants (listing, ajout, suppression ...) #
  #######################################################################

  # -- Constructeur --
  def initialize
    @participants = []
  end

  # -- Accéder au tableau des Participants --
  def getParticipants
    return @participants
  end

  # -- Listing des participants (sans focus) --
  def listerParticipants
    puts ""
    puts "--| Liste des participants |--"
    puts ""
    @participants.each do |participant|
      puts "  #{participant.nom} - INIT #{participant.initiative}"
    end
    puts ""
    puts "--| -------------------------- |--"
    puts ""
  end


  # -- Methode permettant de déterminer si un nom de personnage saisi est bien existant --
  def presenceNom(participant_nom)
    presence_nom = false
    @participants.each do |participant|
      if participant.nom == participant_nom
        presence_nom = true
      end
    end
    return presence_nom
  end

  # -- Retourne le participant (Objet) en faisant la correspondance avec le nom saisi par l'utilisateur (String) --
  def recupNom(participant_nom)
    @participants.each do |participant|
      if participant.nom == participant_nom
        return participant
      end
    end
  end

  # -- Fonction de tri des participants par ordre décroissant de leur initiative  --
  def triParticipantsParInit
    @participants = @participants.sort do |participant_a, participant_b|
      participant_b.initiative  <=> participant_a.initiative
    end
  end

  # -- Ajout d'un participan au combat --
  def ajoutParticipants(participant)
    @participants.push(participant)
  end

  # -- Suppression d'un participant au combat --
  def supprimeParticipant(participant_nom)
        participant = self.recupNom(participant_nom)
        @participants.delete(participant)
  end

  # -- Renvoi le nombre d'objets (participants) du tableau  --
  def nombreParticipants
    return @participants.length
  end

  ################################################################
  # Gestion générale du focus (initialisation, transmission ...) #
  ################################################################

  # -- Methode de recherche de l'initiative la plus haute --
  def maxInit
    liste_init = []
    @participants.each do |participant|
      liste_init.push(participant.initiative)
    end
    return liste_init.max
  end

  # -- Methode destinée à caler le focus sur l'init la plus haute --
  def initFocus(max_initiative)
    @participants.each do |participant|
      if participant.initiative == max_initiative
        participant.focus = true
      end
    end
  end

  # -- Afficher le focus du participant en cours --
  def focusParticipants(compteur)
      puts @participants[compteur].nom
  end

  # -- Affichage du tour en cours --
  def afficheFocusDepartParticipants
    puts ""
    puts "--| Liste des participants |--"
    puts ""
    @participants.each do |participant|
      if participant.focus == true
        puts "* #{participant.nom} - INIT #{participant.initiative} - PV restants (#{participant.pv} / #{participant.pv_max})"
      else
        puts "  #{participant.nom} - INIT #{participant.initiative} - PV restants (#{participant.pv} / #{participant.pv_max})"
      end
    end
    puts ""
    puts "--| -------------------------- |--"
    puts ""
  end

  # -- Gestion de l'affichage et de la transition du focus (via modifFocus) --
  def afficheFocusParticipants(compteur)
    puts ""
    @participants.each do |participant|
      if participant.focus == true
        puts "* #{participant.nom} - INIT #{participant.initiative} - PV restants (#{participant.pv} / #{participant.pv_max})"
      else
        puts "  #{participant.nom} - INIT #{participant.initiative} - PV restants (#{participant.pv} / #{participant.pv_max})"
      end
    end
    puts ""
    modifFocus(compteur)
  end

  # -- Méthode permettant de déplacer le focus d'un joueur au suivant --
  def modifFocus(compteur)
    puts "coucou"
    @participants[compteur].focus = false
    if compteur == @participants.length-1.to_i
      compteur = -1
      puts "heu"
    end
      @participants[compteur+1].focus = true
      puts "bah"
  end

  # -- Méthode permettant de donner manuellement le focus à un participant --
  def donnerFocus(participant_nom)
    @participants.each do |participant|
      if participant.nom == participant_nom
        participant.focus = true
      else
        participant.focus = false
      end
    end
  end
end

# ----------------------------------------------------------------------

######################
# Classe Personnnage #
######################

class Personnage

# ----------------------------------------------------------------------

  ##################################################################################
  # Gestion générale des Personnages (création, affichage des caractéristiques...) #
  ##################################################################################

  attr_accessor :nom, :initiative, :pv_max, :pv, :focus, :etat

  # -- Constructeur --
  def initialize(nom)
    @nom = nom
    @initiative = 0
    @pv_max = 0
    @pv = 0
    @focus = false
    @etat = {
        nom_etat: "",
        description:  "",
        }
  end

  # -- Méthode d'affichage des caractéristiques d'un personnage
  def afficheCarac()
    puts "-- Affichage des caractéristiques de #{@nom} --"
    puts ""
    puts "#{@nom} - INIT #{@initiative}"
    puts "(PV : #{@pv} / #{@pv_max} MAX)"
    puts ""
    puts "ETAT ACTUEL : #{@etat[:nom]}"
    puts "------------- CARACTERISTIQUES ----------------"
    puts ""
  end

  # -- Définition des caractéristiques générales
  def setCarac(nom, initiative, pv_max, pv, focus)
    @nom = nom
    @initiative = initiative
    @pv_max = pv_max
    @pv = pv
    @focus = focus
  end

  # -- Définition de l'initiative indépendante
  def setInit(initiative)
    @initiative = initiative
  end

  # -- Méthode de retrait de points de vie lors d'une attaque
  def retraitPV(retrait_pv)
    @pv -= retrait_pv
    puts ""
    puts "#{self.nom} à perdu #{@pv} PV !"
    puts "Il reste désormais #{@pv} PV à #{self.nom} sur un total de #{@pv_max} PV MAX"
    puts ""
  end

  # -- Méthode d'ajout de points de vie lors d'un soin (potion, sort ...)
  def ajoutPV(ajout_pv)
    @pv += ajout_pv
    puts ""
    puts "#{self.nom} à gagné #{@pv} PV !"
    puts "Il reste désormais #{@pv} PV à #{self.nom} sur un total de #{@pv_max} PV MAX"
    puts ""
  end

  # -- Définition de l'etat du participant
  def setEtat(etat)
    @etat[:nom] = etat
  end

end

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
aral.setCarac("Aral", 0, 100, 100, false)
participants.ajoutParticipants(aral)
barash = Personnage.new("Barash")
barash.setCarac("Barash", 0, 100, 100,false)
participants.ajoutParticipants(barash)
bendak = Personnage.new("Bendak")
bendak.setCarac("Bendak", 0, 100, 100, false)
participants.ajoutParticipants(bendak)
drake = Personnage.new("Drake")
drake.setCarac("Drake", 0, 100, 100, false)
participants.ajoutParticipants(drake)
erazal = Personnage.new("Erazal")
erazal.setCarac("Erazal", 0, 100, 100, false)
participants.ajoutParticipants(erazal)
himoreal = Personnage.new("Himoreal")
himoreal.setCarac("Himoreal", 0, 100, 100, false)
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
    puts "Saisissez l'initiative de #{participant.nom}"
    initiative_depart = gets.chomp.to_i
    if initiative_depart >= 1 && initiative_depart <= 20
      participant.setInit(initiative_depart)
    else
      puts ""
      puts "ATTENTION : l'initiative de #{participant.nom} n'est pas comprise entre 0 et 20 !"
      puts ""
      participant.setInit(999)
    end
end

participants.triParticipantsParInit

ajouter_participant = ""

# -- Ajout des joueurs supplémentaires pour initier le combat (typiquement des monstres ou des PNJ alliés) --
while ajouter_participant != "Non" || ajouter_participant == "N"

  puts "--| Ajouter un participant ? : 1. (O)ui, 2. (N)on"
  ajouter_participant = gets.chomp.to_s.upcase

  if ajouter_participant == "Oui" || ajouter_participant == "O"
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
    nouveau_participant.setCarac(nouveau_participant.nom, nouveau_participant_init, nouveau_participant_pv_max, nouveau_participant_pv, false)
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

  ajuster_initiative = gets.chomp.to_s.upcase

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

# -- Calage du focus sur le personnage qui a l'initiative la plus haute --
max_initiative = participants.maxInit()
participants.initFocus(max_initiative)

commande = ""
compteur = 0

#################################################
# Interface utilisateur principale du programme #
#################################################

puts ""
puts ""
puts ""
puts "                                                                              "
puts "    .-._                                                   _,-,               "
puts "     `._`-._                                           _,-'_,'                "
puts "         `._ `-._                                   _,-' _,'                  "
puts "            `._  `-._        __.-----.__        _,-'  _,'                     "
puts "               `._   `#==='''           '''===#'   _,'                        "
puts "                  `._/)  ._               _.  (\_,'                           "
puts "                   )*'     **.__     __.**     '*(                            "
puts "                   #  .==..__  ''   ''  __..==,  #                            "
puts "                   #   `''._(_).       .(_)_.''' #                            "
puts "------------------------------------------------------------------------------"
puts ""
puts ""
puts ""

while commande != "Quitter" && commande != "Q"

  puts "--| Commandes disponibles :  1. '(L)ister', 2. '(C)arac' 3. '(A)jouter', 4. '(J)ouer', 5. '(Q)uitter' |--"
  puts ""

  commande = gets.chomp.to_s.upcase

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

    nouveau_participant.setCarac(nouveau_participant.nom, nouveau_participant_init, nouveau_participant_pv_max, nouveau_participant_pv, false)
    participants.ajoutParticipants(nouveau_participant)
    participants.triParticipantsParInit

  elsif commande == "Carac" || commande == "C"
    puts "--| Sélectionnnez le personnage dont vous souhaitez afficher les caractéristiques : --|"
    personnage_nom = gets.chomp.to_s
    if participants.presenceNom(personnage_nom) == true
      personnage_nom = participants.recupNom(personnage_nom)
      personnage_nom.afficheCarac()
    else
      puts ""
      puts "! Ce participant n'existe pas !"
      puts ""
    end

  elsif commande == "Jouer" || commande == "J"
    participants.afficheFocusDepartParticipants()
    action = ""
    while action != "Retour" && action != "R"
      puts "--| Sélectionner l'action de jeu : 1. '(S)uivant', 2. '(F)ocus', 3. '(L)ister', 4. '(A)ttaque', 5. '(So)in', 6. '(E)tat', 7. '(M)ort', 8. '(R)etour' |--"
      action = gets.chomp.to_s.upcase

      if action == "Suivant" || action == "S"
        puts "Numero du tour : <#{compteur}>"
          participants.afficheFocusParticipants(compteur)
          if compteur == nombre_participants-1.to_i
            compteur = -1
          end
          compteur += 1

      elsif action == "Focus" || action == "F"
        puts "-> Saisissez le participant à qui donner le focus : "
        personnage_nom = gets.chomp.to_s
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
        personnage_nom = gets.chomp.to_s

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

      elsif action == "Soin" || action == "So"
        puts "-> Sélectionnnez le personnage auquel ajouter des PV : "
        personnage_nom = gets.chomp.to_s

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
        personnage_nom = gets.chomp.to_s

        if participants.presenceNom(personnage_nom) == true
            personnage_nom = participants.recupNom(personnage_nom)
            puts "-> Entrez l'état : "
            etat = gets.chomp.to_s
            personnage_nom.setEtat(etat)
        else
          puts ""
          puts "! Ce participant n'existe pas !"
          puts ""
        end

      elsif action == "Mort" || action == "M"
        puts "--| Entrez le personnage déclaré mort : --|"
        personnage_nom = gets.chomp.to_s
        if participants.presenceNom(personnage_nom) == true
          participants.supprimeParticipant(personnage_nom)
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
