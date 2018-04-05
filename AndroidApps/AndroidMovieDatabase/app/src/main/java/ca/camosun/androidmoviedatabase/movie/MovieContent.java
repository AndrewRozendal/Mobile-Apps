package ca.camosun.androidmoviedatabase.movie;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *  Contains all Conversions in collections for access throughout the app
 */
public class MovieContent {

    /**
     * An array of Movie items.
     */
    public static final List<Movie> ITEMS = Movie.generateConversions();

    /**
     * A map of Movie items, by ID.
     */
    public static final Map<String, Movie> ITEM_MAP = new HashMap<String, Movie>();

    /**
     * The number of Movie items
     */
    private static final int COUNT = ITEMS.size();

    static {
        // Add all Movie ITEMS to the Map with their ID
        for (int i = 0; i < COUNT; i++) {
            ITEM_MAP.put(Integer.toString(ITEMS.get(i).getId()), ITEMS.get(i));
        }
    }
}
