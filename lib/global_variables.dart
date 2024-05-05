import 'models/movies_model.dart';

class GlobalVars {
  static List<MoviesModel> popularMovies = [];
  static String moviesPrefKey = 'moviesKey';
  static String seriesPrefKey = 'seriesKey';
  static String animePrefKey = 'animeKey';
  static List<String> mostPopularSeries = ['friends','game of thrones','modern family','The boys','Dark','Mr robot','Dexter','Stranger Things','breaking bad','Lucifer'];
  static List<String> mostPopularMovies = ['Dune: part two','Interstellar','Top gun: maverick','Jurassic Park','The Dark knight','The Avengers','Night at the Museum','Jumanji','fast & furious','American Psycho','Lucy'];
  static List<String> mostPopularAnime = ['Naruto: Shippuden','One Piece','Death Note','Demon Slayer: Kimetsu no Yaiba','Jujutsu Kaisen','Parasyte: The Maxim','Chainsaw Man','Claymore','Attack on titan','The Grimm Variations','Vinland saga'];
}