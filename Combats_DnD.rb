# -> Gérer complètement le focus
# -> Gérer une initiative égale entre plusieurs participants. Dans ce cas : le joueur relance.

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

  # -- Listing des participants (sans focus) --
  def listerParticipants
    puts ""
    puts "--| Liste des participants |--"
    puts ""
    @participants.each do |participant|
      puts "#{participant.nom} - INIT #{participant.initiative}"
    end
    puts ""
    puts "--| -------------------------- |--"
    puts ""
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
      if participant.nom = participant_nom
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

  attr_accessor :nom, :initiative, :pv_max, :pv, :focus

  # -- Constructeur --
  def initialize(nom)
    @nom = nom
    @initiative = 0
    @pv_max = 0
    @pv = 0
    @focus = false
  end

  # -- Méthode d'affichage des caractéristiques d'un personnage
  def afficheCarac()
    puts "-- Affichage des caractéristiques de #{@nom} --"
    puts ""
    puts "#{@nom} - INIT #{@initiative}"
    puts "(PV : #{@pv} / #{@pv_max} MAX)"
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

  # -- Définition de l'initiative
  def setInit(initiative)
    @initiative = initiative
  end

  # -- Méthode de retrait de points de vie lors d'une attaque
  def retraitPV(retrait_pv)
    @pv -= retrait_pv
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
himoreal = Personnage.new("Himoreal")
himoreal.setCarac("Himo", 0, 100, 50, false)
participants.ajoutParticipants(himoreal)
aral = Personnage.new("Aral")
aral.setCarac("Aral", 10, 0, 50, false)
participants.ajoutParticipants(aral)
bendak = Personnage.new("Bendak")
bendak.setCarac("Bendak", 8, 0, 50, false)
participants.ajoutParticipants(bendak)
drake = Personnage.new("Drake")
drake.setCarac("Drake", 4, 0, 50, false)
participants.ajoutParticipants(drake)
barash = Personnage.new("Barash")
barash.setCarac("Barash", 6, 0, 50,false)
participants.ajoutParticipants(barash)
erazal = Personnage.new("Erazal")
erazal.setCarac("Erazal", 1, 0, 50, false)
participants.ajoutParticipants(erazal)

nombre_participants = participants.nombreParticipants
puts nombre_participants

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

puts "--| Début du jeu |--"
puts "--| Initialisation des joueurs de base |--"
puts ""

puts "-> Saisissez l'initiative (INIT) de ARAL : "
initiative_depart =  gets.chomp.to_i
aral.setInit(initiative_depart)

puts "-> Saisissez l'initiative (INIT) de BARASH : "
initiative_depart =  gets.chomp.to_i
barash.setInit(initiative_depart)

puts "-> Saisissez l'initiative (INIT) de BENDAK : "
initiative_depart =  gets.chomp.to_i
bendak.setInit(initiative_depart)

puts "-> Saisissez l'initiative (INIT) de DRAKE : "
initiative_depart =  gets.chomp.to_i
drake.setInit(initiative_depart)

puts "-> Saisissez l'initiative (INIT) de ERAZAL : "
initiative_depart =  gets.chomp.to_i
erazal.setInit(initiative_depart)

puts "-> Saisissez l'initiative (INIT) de HIMOREAL : "
initiative_depart =  gets.chomp.to_i
himoreal.setInit(initiative_depart)

participants.triParticipantsParInit

ajouter_participant = ""

# -- Ajout des joueurs supplémentaires pour initier le combat (typiquement des monstres ou des PNJ alliés) --
while ajouter_participant != "Non" || ajouter_participant == "N"

  puts "--| Ajouter un participant ? : 1. (O)ui, 2. (N)on"
  ajouter_participant = gets.chomp.to_s

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

# -- Calage du focus sur le personnage qui a l'initiative la plus haute --
max_initiative = participants.maxInit()
participants.initFocus(max_initiative)

commande = ""
compteur = 0

#################################################
# Interface utilisateur principale du programme #
#################################################

while commande != "Quitter" && commande != "Q"

  puts "--| Commandes disponibles :  1. '(L)ister', 2. '(C)arac' 3. '(A)jouter', 4. '(J)ouer', 5. '(Q)uitter' |--"
  puts ""

  commande = gets.chomp.to_s

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
    personnage_nom = participants.recupNom(personnage_nom)
    personnage_nom.afficheCarac()


  elsif commande == "Jouer" || commande == "J"
    participants.afficheFocusDepartParticipants()
    action = ""
    while action != "Retour" && action != "R"
      puts "--| Sélectionner l'action de jeu : 1. '(S)uivant', 2. '(F)ocus', 3. '(L)ister', 4. 'PV', 5. '(M)ort', 6. '(R)etour' |--"
      action = gets.chomp.to_s

      if action == "Suivant" || action == "S"
        puts "Numero du tour : <#{compteur}>"
          participants.afficheFocusParticipants(compteur)
          if compteur == nombre_participants-1.to_i
            compteur = -1
          end
          compteur += 1

      elsif action == "Focus" || action == "F"
        puts "-> Saisissez le participant à qui donner le focus : "
        focus_participant = gets.chomp.to_s
        participants.donnerFocus(focus_participant)

      elsif action == "Lister" || action == "L"
        participants.afficheFocusDepartParticipants()

      elsif action == "PV"
        puts "-> Sélectionnnez le personnage auquel retirer des PV : "
        personnage_nom = gets.chomp.to_s
        personnage_nom = participants.recupNom(personnage_nom)
        puts "-> Entrez le nombre de points de vie retirés : "
        pv_retrait = gets.chomp.to_i
        personnage_nom.retraitPV(pv_retrait)

      elsif action == "Mort" || action == "M"
        puts "--| Entrez le personnage déclaré mort : --|"
        participant_mort = gets.chomp.to_s
        participants.supprimeParticipant(participant_mort)
        participants.listerParticipants()
      end
    end
  end
end
