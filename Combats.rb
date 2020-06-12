
# -- Gestion automatisée des combats pour une partie de D&D --

# -- Fonction de tri des participants  --
def tri_participants(f_participants)
  f_tour = f_participants.sort do |participant_a, participant_b|
    participant_a[:initiative]  <=> participant_b[:initiative]
  end
  return f_tour
end

# -- Fonction d'affichage des participants --
def affichage_participants(f_participants)
  puts "Ordre des participants selon les jets d'initiative :"
  puts ""
  f_participants.each do |participant|
    puts "#{participant[:nom]} (PV : #{participant[:pv]}/#{participant[:pv_max]}) - #{participant[:initiative]}"
  end
  puts ""
end

# -- Fonction d'affichage des caractéristiques d'un participant --
def affichage_carac(f_joueurs, f_joueur)
  puts "Affichage de la fiche personnage"
  puts ""
  f_joueurs.each do |joueur|
    if f_joueur == joueur[:nom]
      puts ""
      puts "#{joueur[:nom]} - #{joueur[:initiative]}"
      puts "(PV : #{joueur[:pv]}/#{joueur[:pv_max]})"
      puts ""
    end
  end
end

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
=end

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
