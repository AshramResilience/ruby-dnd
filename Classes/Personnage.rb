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
    @etat = ""
  end

  # -- Méthode d'affichage des caractéristiques d'un personnage
  def afficheCarac()
    puts "-- Affichage des caractéristiques de #{@nom} --"
    puts ""
    puts "#{@nom} - INIT #{@initiative}"
    puts "(PV : #{@pv} / #{@pv_max} MAX)"
    puts ""
    puts "ETAT ACTUEL : #{@etat} "
    puts "------------- CARACTERISTIQUES ----------------"
    puts ""
  end

  # -- Définition des caractéristiques générales
  def setCarac(nom, initiative, pv_max, pv, focus, etat)
    @nom = nom
    @initiative = initiative
    @pv_max = pv_max
    @pv = pv
    @focus = focus
    @etat = etat
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
    @etat = etat
  end
end
