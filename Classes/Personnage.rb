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
    puts ""
    puts ""
    puts "------------- CARACTERISTIQUES DE [#{@nom.upcase}] ---"
    puts ""
    puts "#{@nom.upcase} - INIT #{@initiative}"
    puts "(PV : #{@pv} / #{@pv_max} MAX)"
    puts ""
    puts "ETAT(S) ACTUEL(S) : #{@etat} "
    puts ""
    puts "------------- CARACTERISTIQUES ----------------"
    puts ""
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
    puts ""
    puts "---------- ATTAQUE ! ----------------"
    puts ""
    puts "#{self.nom.upcase} à perdu #{retrait_pv} PV !"
    puts "PV restants : #{@pv}/#{@pv_max}"
    puts ""
    puts "---------- FIN DE L'ATTAQUE ---------"
    puts ""
    puts ""
  end

  # -- Méthode d'ajout de points de vie lors d'un soin (potion, sort ...)
  def ajoutPV(ajout_pv)

    @pv += ajout_pv
    if @pv >= @pv_max
      @pv = @pv_max
    end

    puts ""
    puts ""
    puts "---------- SOIN ! ----------------"
    puts ""
    puts "#{self.nom.upcase} à gagné #{ajout_pv} PV !"
    puts "PV restants : #{@pv}/#{@pv_max}"
    puts ""
    puts "---------- FIN DU SOIN -----------"
    puts ""
    puts ""
  end

  # -- Définition de l'etat du participant
  def setEtat(etat)
    @etat = etat
  end
end
