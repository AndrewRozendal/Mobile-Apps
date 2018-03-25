package ca.camosun.masterdetailconverter.conversion;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *  Contains all Conversions in collections for access throughout the app
 */
public class ConversionContent {

    /**
     * An array of Conversion items.
     */
    public static final List<Conversion> ITEMS = Conversion.generateConversions();

    /**
     * A map of Conversion items, by ID.
     */
    public static final Map<String, Conversion> ITEM_MAP = new HashMap<String, Conversion>();

    /**
     * The number of Conversion items
     */
    private static final int COUNT = ITEMS.size();

    static {
        // Add all Conversion ITEMS to the Map with their ID
        for (int i = 0; i < COUNT; i++) {
            ITEM_MAP.put(Integer.toString(ITEMS.get(i).getId()), ITEMS.get(i));
        }
    }
}
