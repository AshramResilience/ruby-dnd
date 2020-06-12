# Exercice pour utiliser les classes

class Joueur

  # Accès en lecture à mes deux attributs
  #attr_reader :nom , :niveau

  # accès en écriture uniquement à l'attribut niveau
  #attr_writer :niveau

  attr_accessor :nom , :niveau
  # Permet l'accès en lecture et en écriture à mes deux attributs.

  # Le nom de cette méthode est fixe "initialize" !
  def initialize(nom, niveau)
    @nom = nom
    @niveau = niveau
  end

  def afficher
    puts "Le nom du joueur est : " + @nom
    puts "Le niveau du joueur est : " + @niveau
  end

  # Permet de modifier directement l'attribut
  def modifier=(nom)
    @nom = nom
  end
end


# ----- Début du programme -----
joueur = Joueur.new("Ashram", "15")

# On affiche le nom et le niveau
puts joueur.nom
puts joueur.niveau
puts ""


joueur.modifier = ("Barash")
joueur.niveau = "17"
joueur.afficher
puts ""
puts joueur.nom
