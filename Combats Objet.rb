# -- Gestion automatisée des combats pour une partie de D&D --
# -- Version 0.2  --

# Classe du groupe de participants --
class Participants

  # Constructeur
  def initialize
    @participants = []
  end

  # -- Lister les participants (sans focus)
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

  # -- Ajout de participants au combat --
  def ajoutParticipants(participant)
    @participants.push(participant)
  end

  # -- Suppression de participants au combat --
  def supprimeParticipant(participant_nom)
        participant = self.recupNom(participant_nom)
        @participants.delete(participant)
  end


  # -- Methode de recherche de l'INIT la plus basse pour caler le focus après l'ajout de tous les participants --
  def maxInit
    liste_init = []

    @participants.each do |participant|
      liste_init.push(participant.initiative)
    end
    return liste_init.max
  end

  # -- Methode destinée à caler le focus sur l'init la plus basse --
  def initFocus(min_initiative)
    @participants.each do |participant|
      if participant.initiative == min_initiative
        participant.focus = true
      end
    end
  end

  # -- Fonction de tri des participants par ordre décroissant de leur initiative  --
  def triParticipantsParInit
    @participants = @participants.sort do |participant_a, participant_b|
      participant_b.initiative  <=> participant_a.initiative
    end
  end

  # -- Renvoi le nombre d'objets (participants) du tableau  --
  def nombreParticipants
    return @participants.length
  end

  # -- Afficher le focus du participant en cours --
  def focusParticipants(compteur)
      puts @participants[compteur].nom
  end

  # -- Affichage du tour en cours --
  def afficheFocusDepartParticipants
    @participants.each do |participant|
      if participant.focus == true
        puts "* #{participant.nom}"
      else
        puts "  #{participant.nom}"
      end
    end
  end

  # -- Afficher le focus du participant en cours --
  def afficheFocusParticipants(compteur)
    @participants.each do |participant|
      if participant.focus == true
        puts "* #{participant.nom}"
      else
        puts "  #{participant.nom}"
      end
    end
    modifFocus(compteur)
  end

  # -- Fonction permettant de déplacer le focus d'un joueur au suivant
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
end



# -- Classe Personnage --
class Personnage
  attr_accessor :nom, :initiative, :pv_max, :pv, :focus

  def initialize(nom)
    @nom = nom
    @initiative = 0
    @pv_max = 0
    @pv = 0
    @focus = false
  end

  def afficheCarac()
        puts "-- Affichage des caractéristiques de #{@nom} --"
        puts ""
        puts "#{@nom} - INIT #{@initiative}"
        puts "(PV : #{@pv} / #{@pv_max} MAX)"
        puts ""
  end

  def setCarac(nom, initiative, pv_max, pv, focus)
    @nom = nom
    @initiative = initiative
    @pv_max = pv_max
    @pv = pv
    @focus = focus
  end

  def setInit(initiative)
    @initiative = initiative
  end

  def retraitPV(retrait_pv)
    @pv -= retrait_pv
  end
end


# -- Création d'un tableau vide de participants
participants = Participants.new()

# -- Création de mes participants, puis set de leurs variables d'instance
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

#participants.focusParticipants(nombre_participants)


#  -- Début du programme - Initialisation du jeu --

puts "--| Début du jeu |--"
puts "--| Initialisation des joueurs de base |--"

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

max_initiative = participants.maxInit()
participants.initFocus(max_initiative)

commande = ""
compteur = 0

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
        ###
      elsif action == "Lister" || action == "L"
        ###
      elsif action == "PV"

        puts "--| Sélectionnnez le personnage auquel retirer des PV : --|"
        personnage_nom = gets.chomp.to_s
        personnage_nom = participants.recupNom(personnage_nom)

        puts "--| Entrez le nombre de points de vie retirés : --|"
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


=begin
# -- Fonction d'initialisation de l'initiative --
def init_initiative(f_participants, f_joueur, f_initiative)
  f_participants.each do |joueur|
    if joueur[:nom] == f_joueur
      joueur[:initiative] = f_initiative
      puts ""
      puts "Le joueur #{joueur[:nom]} dispose de l'initiative : #{joueur[:initiative]}"
      puts ""
    end
  end
end


# -- Fonction d'ajout de participants à un combat. Typiquement : des monstres --
def ajout_participant(f_nom, f_initiative, f_pv, f_pv_max)
  participant_nouveau = {
    nom: f_nom,
    initiative:  f_initiative,
    pv:  f_pv,
    pv_max: f_pv_max
  }
  return participant_nouveau
end


# -- Fonction d'affichage du focus des participants --
=begin
def affichage_focus(f_participants)
  puts "Ordre des participants selon les jets d'initiative et leur focus :"
  puts ""
  f_participants.each do |participant|
    if participant[:focus] == "*"
      puts "#{participant[:nom]} (PV : #{participant[:pv]}/#{participant[:pv_max]}) - #{participant[:initiative]}"
      participant[:focus] = ""
    else
      puts "   #{participant[:nom]} (PV : #{participant[:pv]}/#{participant[:pv_max]}) - #{participant[:initiative]}"
    end
  end
  puts ""
end


# -- Fonction permettant de donner manuellement le focus à un participant --
def donner_focus(f_participants, f_joueur)
  puts "Joueur ayant le focus"
  puts ""
  f_participants.each do |joueur|
    if f_joueur == joueur[:nom]
      puts " * #{joueur[:nom]} (PV : #{joueur[:pv]}/#{joueur[:pv_max]}) - #{joueur[:initiative]}"
    else
      puts "   #{joueur[:nom]} (PV : #{joueur[:pv]}/#{joueur[:pv_max]}) - #{joueur[:initiative]}"
    end
  end
  puts ""
end

# -- Fonction permettant de lister les participants en indiquant sur qui est le focus --
def lister_focus(f_participants, joueur)
  puts "Joueur en cours"
  puts ""
  f_participants.each do |joueur|
    if f_joueur == joueur[:nom]
      puts " * #{joueur[:nom]} (PV : #{joueur[:pv]}/#{joueur[:pv_max]}) - #{joueur[:initiative]}"
    else
      puts "#{joueur[:nom]} (PV : #{joueur[:pv]}/#{joueur[:pv_max]}) - #{joueur[:initiative]}"
    end
  end
  puts ""
end

# -- Fonction permettant un retrait manuel de point --
def retrait_pv(f_participants, f_joueur, f_pv_en_moins)
  f_participants.each do |joueur_touche|
    if f_joueur == joueur_touche[:nom]
      joueur_touche[:pv] -= f_pv_en_moins
      puts ""
      puts "Le joueur #{joueur_touche[:nom]} dispose de #{joueur_touche[:pv]}PV sur #{joueur_touche[:pv_max]}PV restants"
      puts ""
    end
  end
end

# -- Initialisation des mes participants fixes (typiquement les joueurs) --
participants = []



himoreal = ajout_participant("Himoreal", 0, 100, 100)
participants << himoreal
aral = ajout_participant("Aral", 0, 100, 100)
participants << aral
bendak = ajout_participant("Bendak", 0, 100, 100)
participants << bendak
drake = ajout_participant("Drake", 0, 100, 100)
participants << drake
barash = ajout_participant("Barash", 0, 100, 100)
participants << barash
erazal = ajout_participant("Erazal", 0, 100, 100)
participants << erazal

puts "Pour Himoreal, indiquez l'initiative : "
initiative =  gets.chomp.to_i
himoreal = init_initiative(participants, "Himoreal", initiative)

puts "Pour Aral, indiquez l'initiative : "
initiative =  gets.chomp.to_i
init_initiative(participants, "Aral", initiative)

puts "Pour Bendak, indiquez l'initiative : "
initiative =  gets.chomp.to_i
init_initiative(participants, "Bendak", initiative)

puts "Pour Drake, indiquez l'initiative : "
initiative =  gets.chomp.to_i
init_initiative(participants, "Drake", initiative)

puts "Pour Barash, indiquez l'initiative : "
initiative =  gets.chomp.to_i
init_initiative(participants, "Barash", initiative)

puts "Pour Erazal, indiquez l'initiative : "
initiative =  gets.chomp.to_i
init_initiative(participants, "Erazal", initiative)


tour = tri_participants(participants)

# -- Débuter le combat --
commande = ""

#  -- Début du programme - Initialisation du jeu --
while commande != "Quitter" && commande != "Q"

  tour = tri_participants(participants)
  puts "Commandes disponibles :  1. '(L)ister', 2. '(C)arac' 2. '(A)jouter', 3. '(J)ouer', 4. '(Q)uitter'"
  commande = gets.chomp.to_s
  if commande == "Lister" || commande == "L"
    affichage_participants(tour)
  elsif commande == "Ajouter" || commande == "A"
    puts "Sélectionner un nom"
    nom_reponse = gets.chomp
    puts ""

    puts "Sélectionner son initiative"
    initiative_reponse = gets.chomp.to_i
    puts ""

    puts "Selectionner ses points de vie"
    pv_reponse = gets.chomp.to_i
    puts ""

    puts "Selectionner ses points de vie MAX"
    pv_max_reponse = gets.chomp.to_i
    puts ""

    nouveau_participant = ajout_participant(nom_reponse, initiative_reponse, pv_reponse, pv_max_reponse)
    participants << nouveau_participant

  elsif commande == "Carac" || commande == "C"
    puts "Choisissez le joueur (himoreal, drake, aral...)"
    joueur = gets.chomp
    affichage_carac(participants, joueur)

  elsif commande == "Jouer" || commande == "J"
    action = ""
    numero_tour = 0
    participants = tri_participants(participants)
    while action != "Retour" && action != "R"
      puts "Sélectionner l'action de jeu : 1. '(S)uivant', 2. '(F)ocus', 3. '(L)ister', 4. 'PV', 5. '(R)etour'"
      action = gets.chomp

      if action == "Suivant" || action == "S"
        if numero_tour > 6
          numero_tour = 1
        end
        numero_tour += 1
        puts "Numero de tour : #{numero_tour.to_s}"

      elsif action == "Focus" || action == "F"
        puts "Choisissez le joueur (himoreal, drake, aral...)"
        joueur = gets.chomp

        donner_focus(participants, joueur)
      elsif action == "Lister" || action == "L"
        donner_focus(participants, joueur)

      elsif action == "PV"
        puts "Choisissez le joueur (himoreal, drake, aral...)"
        joueur = gets.chomp
        puts "Choisissez le nombre de PV à retirer"
        pv_en_moins = gets.chomp.to_i
        retrait_pv(participants, joueur, pv_en_moins)
      end
    end
  end
end

=end