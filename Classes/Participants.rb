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
