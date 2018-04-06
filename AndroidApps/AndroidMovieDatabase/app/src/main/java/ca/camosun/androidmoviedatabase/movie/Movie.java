package ca.camosun.androidmoviedatabase.movie;

import java.util.ArrayList;
import java.util.List;

// A Movie that can be performed.  Contains two buttons to provide conversions between two
// different units of measurement in both directions
public class Movie {
    // the unique id of the conversion
    private int id;
    // the name to display for the conversion
    private String name;
    // the genres the movie belongs to
    private List<Genres> genres;
    // the actors in the movie
    private List<String> actors;
    // the user rating for the movie
    public float rating;
    // if the movie is a user favourite
    public boolean isFavourite;
    // user comments for the movie
    private String comments;
    // the resourceID for the image in the android package
    private String imageID;
    // tracks the next unique id for each new conversion
    private static int IDCOUNTER = 0;

    // returns the next uniqe id for each new conversion and increments static counter
    private int generateID(){
        return IDCOUNTER++;
    }

    // Initializes the Movie with its name and its two buttons to perfom unit conversions.
    // TODO: Add param for the image to associate with the movie?
    public Movie(String name, List<Genres> genres, List<String> actors, int rating, boolean isFavourite, String comments) {
        this.id = generateID();
        this.name = name;
        this.genres = genres;
        this.actors = actors;
        this.rating = rating;
        this.isFavourite = isFavourite;
        this.comments = comments;
        // TODO fix this! Hardcoded for now, need to update constructor parameters
        this.imageID = "default";
    }

    // public accessor for id
    public int getId(){
        return this.id;
    }

    // Public accessor for name
    public String getName(){
        return this.name;
    }

    // public accessor for genres
    public List<Genres> getGenres(){ return this.genres; }

    // public accessor for actors
    public List<String> getActors(){ return this.actors; }

    //public accessor for comments
    public String getComments(){ return this.comments; }

    // public accessor for image
    public String getImageID(){ return this.imageID; }

    // Helper method to generate all available conversions.  To add a conversion, simply instantiate
    // a new Movie object and append to the ArrayList.
    public static ArrayList<Movie> generateConversions(){

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

        movies.add(new Movie("Titanic", currentGenres, currentActors, 3, false, "Very sad"));

        currentGenres = new ArrayList<>();
        currentGenres.add(Genres.Action);

        currentActors = new ArrayList<>();
        currentActors.add("Tom Hanks");

        movies.add(new Movie("Saving Private Ryan", currentGenres, currentActors, 5, true, "A classic"));

        currentGenres = new ArrayList<>();
        currentGenres.add(Genres.SciFi);

        currentActors = new ArrayList<>();
        currentActors.add("Mark");

        movies.add(new Movie("Star Wars Episode I", currentGenres, currentActors, 4, false, "First prequel movie"));
        movies.add(new Movie("Star Wars Episode II", currentGenres, currentActors, 4, false, "Second prequel movie"));

        currentGenres = new ArrayList<>();
        currentGenres.add(Genres.SciFi);
        currentGenres.add(Genres.Action);

        currentActors = new ArrayList<>();
        currentActors.add("Jane");
        currentActors.add("Jon");
        currentActors.add("Mary");

        movies.add(new Movie("Avatar", currentGenres, currentActors, 3, false, "This is a really long test comment.  This is to test that multi-line comments work."));

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