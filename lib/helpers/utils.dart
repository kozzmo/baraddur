import 'dart:core';
import 'dart:developer' as developer;

const bool myDebug = false;
const double myZoom = 2.5;

T estimateCallTime<T>(T Function() action) {
  final stopwatch = Stopwatch()..start();
  final result = action();
  developer.log('The function executed in ${stopwatch.elapsed}');

  return result;
}

final questMessages = {
  "default": "DEFAULT_MESSAGE",
  "notreProjet":
      "C'est notre projet "
      "\nUn cadre atypique: un univers médiéval, des jeux de société faciles à prendre en main aux jeux complexes avec des dizaines de pages de règle, des jeux de rôle, des soirées à thème, des produits locaux pour se remplir le ventre et de la bonne bière.",
  "nosJeux":
      "Nos jeux"
      "\nRetrouvez plus de 150 jeux allant du petit jeux coopératif au gros jeux compétitif. Venez rejouer aux grand classiques et découvrir des vieilles et nouvelles pépites."
      "\n"
      "\nNos breuvages"
      "\nVous pourrez vous rafraichir le gosier avec de nombreuses bières, des boissons d'antan, des jus, des cocktails ainsi qu'une belle sélection de boissons sans alcool."
      "\n"
      "\nLes fringales"
      "\nNous proposons diverses victuailles médiévales de saison. Venez les découvrir sur place !",
  "nosEvenements":
      "Les évènements "
      "\n Nous proposons des soirées à thème, des après-midi et soirées dédiées spécialement à certains jeux."
      "\nN'hésitez pas à consulter la page actualité pour en savoir plus et n' oubliez pas de réserver votre table, les places sont limités.",
  "baraddur":
      "« Barad-dûr »"
      "\n"
      "\nLa tristement célèbre tour où, jadis, Golum cria le nom de « Shire , Baggins »."
      "\nSauron pu y envoyer les Cavaliers noirs et l'aventure de Frodon, Sam et tant d'autres commença."
      "\nC'est une tour d'effroi où l'aventure, les dangers vous guettent."
      "\nOserez-vous y mettre les pieds?"
      "\n"
      "\n« La vie est un grand jeu, on y pioche quelques cartes, on choisit les meilleures, on garde les atouts. »"
      "\nAgnès Ledig",
};

final List<String> noQuestMessages = [
  "On s’emmerde dans cette aventure…",
  "Aucun villageois en détresse… quelle surprise.",
  "Rien ici, à part ton incompétence.",
  "Cette partie est aussi vide qu’une chope renversée.",
  "Tu comptes spammer le bouton ou trouver une quête ?",
  "Même les trolls ont mieux à faire.",
  "Le destin attend… mais pas ici.",
  "Pas de quête. Pas d’honneur. Pas de gloire.",
  "Taper dans le vide ne crée pas de destin.",
  "Tu espérais trouver un trésor là ? Dommage.",
  "Ce n’est pas en priant le bouton que les quêtes apparaissent.",
  "Même le tavernier se demande ce que tu fais.",
  "Tu veux une quête ? Commence par trouver une direction.",
  "Aucun PNJ à l’horizon. Même pas un rat.",
  "Pas de quête, mais tu gagnes un soupir collectif.",
  "L’univers observe… et se moque.",
  "Les dieux du jeu de plateau t’ignorent pour l’instant.",
  "Ce n’est pas ce bouton qui changera ton destin.",
  "Les quêtes, c’est pour les vrais héros.",
];

String? getVariableByName(String name) => questMessages[name];
