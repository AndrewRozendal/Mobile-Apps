package ca.camosun.androidmoviedatabase.movie;

import java.util.ArrayList;
import java.util.List;

import ca.camosun.androidmoviedatabase.R;

/**
 * A class for storing details about a Movie with a unique id and additional details.
 */
public class Movie {
    // the unique id of the conversion
    private int id;
    // the name to display for the conversion
    private String name;
    // the genres for the movie
    private List<Genres> genres;
    // the actors in the movie
    private List<String> actors;
    // the user rating for the movie
    private float rating;
    // if the movie is a user favourite
    public boolean isFavourite;
    // additional comments for the movie
    private String comments;
    // the resourceID for the movie's image in the android package
    private int imageID;

    // tracks the next unique id for each new conversion
    // call generateID() to increment consistently
    private static int IDCOUNTER = 0;

    // returns the next unique id for each new conversion and increments static counter
    private int generateID(){
        return IDCOUNTER++;
    }

    // Initializes a Movie with all of its variables

    /**
     * Initializes a Movie instance with the passed parameters.  This constructor initializes all
     * class attributes for the Movie instance.
     * @param name String the name of the Movie
     * @param genres [Genres] all the genres the Movie belongs to
     * @param actors [String] all the actors that are in the Movie
     * @param rating int the rating for the Movie
     * @param isFavourite boolean if the Movie is a favourite or not
     * @param comments String additional comments about the Movie
     * @param imageResourceID int the Android identifier for the Drawable the Movie should use for
     *                        the Movie image
     * @throws IllegalArgumentException if rating is < 0 or > 5.0
     */
    public Movie(String name, List<Genres> genres, List<String> actors, int rating, boolean isFavourite, String comments, int imageResourceID) {
        this.id = generateID();
        this.name = name;
        this.genres = genres;
        this.actors = actors;

        // use setRating to verify value is in range
        setRating(rating);

        this.isFavourite = isFavourite;
        this.comments = comments;
        this.imageID = imageResourceID;
    }

    /**
     * Initializes a Movie instance with the passed parameters.  This constructor uses the default
     * movie image.  Use the other Movie constructor if you wish to pass an image. The id for the
     * movie is automatically generated based on the next available id in the sequence.
     * @param name String the name of the Movie
     * @param genres [Genres] all the genres the Movie belongs to
     * @param actors [String] all the actors that are in the Movie
     * @param rating int the rating for the Movie
     * @param isFavourite boolean if the Movie is a favourite or not
     * @param comments String additional comments about the Movie
     * @throws IllegalArgumentException if rating is < 0 or > 5.0
     */
    public Movie(String name, List<Genres> genres, List<String> actors, int rating, boolean isFavourite, String comments){
        this(name, genres, actors, rating, isFavourite, comments, R.drawable.moviedefault);
    }

    // public accessor for id
    public int getId(){
        return this.id;
    }

    // public accessor for name
    public String getName(){
        return this.name;
    }

    // public accessor for genres
    public List<Genres> getGenres(){ return this.genres; }

    // public accessor for actors
    public List<String> getActors(){ return this.actors; }

    //public accessor for comments
    public String getComments(){ return this.comments; }

    // public accessor for imageID
    public int getImageID(){
        return this.imageID;
    }

    // public accessor for rating
    public float getRating() { return this.rating; }

    /**
     * Updates the Movie with the newRating after checking if the value is in range
     * @param newRating float the new rating to set.  newRating must be > 0 and <= 5.0
     * @throws IllegalArgumentException if newRating is < 0 or > 5.0
     */
    public void setRating(float newRating){
        if(newRating < 0 || newRating > 5.0){
            throw new IllegalArgumentException("Unable to set rating, value was out of range. " +
                    " newRating must be > 0 and <= 5.0");
        }
        this.rating = newRating;
    }


    /**
     * This method generates a number of predefined Movies.
     * @return ArrayList<Movie> the generated Movie objects
     */
    public static ArrayList<Movie> generateMovies(){

        // Initialize all the movies
        // Store all conversions together
        ArrayList<Movie> movies = new ArrayList<>();

        ArrayList<Genres> currentGenres = new ArrayList<>();
        currentGenres.add(Genres.Action);
        currentGenres.add(Genres.Comedy);

        ArrayList<String> currentActors = new ArrayList<>();
        currentActors.add("Jennifer");
        currentActors.add("Bob");

        movies.add(new Movie("testTitle", currentGenres, currentActors, 5, true, "This is a great movie!!!"));

        currentGenres = new ArrayList<>();
        currentGenres.add(Genres.Romance);

        currentActors = new ArrayList<>();
        currentActors.add("Leo");

        movies.add(new Movie("Titanic", currentGenres, currentActors, 3, false, "Very sad", R.drawable.titanic));

        currentGenres = new ArrayList<>();
        currentGenres.add(Genres.Action);

        currentActors = new ArrayList<>();
        currentActors.add("Tom Hanks");

        movies.add(new Movie("Saving Private Ryan", currentGenres, currentActors, 5, true, "A classic", R.drawable.savingprivateryan));

        currentGenres = new ArrayList<>();
        currentGenres.add(Genres.SciFi);

        currentActors = new ArrayList<>();
        currentActors.add("Mark");

        movies.add(new Movie("Star Wars Episode I", currentGenres, currentActors, 4, false, "First prequel movie", R.drawable.starwarsi));
        movies.add(new Movie("Star Wars Episode II", currentGenres, currentActors, 4, false, "Second prequel movie", R.drawable.starwarsii));

        currentGenres = new ArrayList<>();
        currentGenres.add(Genres.SciFi);
        currentGenres.add(Genres.Action);

        currentActors = new ArrayList<>();
        currentActors.add("Jane");
        currentActors.add("Jon");
        currentActors.add("Mary");

        movies.add(new Movie("Avatar", currentGenres, currentActors, 3, false, "This is a really long test comment.  This is to test that multi-line comments work.", R.drawable.avatar));

        currentGenres = new ArrayList<>();
        currentGenres.add(Genres.Comedy);

        currentActors = new ArrayList<>();
        currentActors.add("Geoff");
        currentActors.add("Bob");

        movies.add(new Movie("testTitle2", currentGenres, currentActors, 4, true, "This is a good movie"));

        currentGenres = new ArrayList<>();
        currentGenres.add(Genres.Documentary);

        currentActors = new ArrayList<>();
        currentActors.add("Jack");
        currentActors.add("Bob");

        movies.add(new Movie("testTitle3", currentGenres, currentActors, 2, true, "This is an ok movie"));

        // Return the populated movie collection
        return movies;
    }
}