package ca.camosun.masterdetailconverter.conversion;

import java.util.ArrayList;

// A Conversion that can be performed.  Contains two buttons to provide conversions between two
// different units of measurement in both directions
public class Conversion {
    // the unique id of the conversion
    private int id;
    // the name to display for the conversion
    private String name;
    // the left button
    private ConversionButton leftButton;
    // the right button
    private ConversionButton rightButton;
    // tracks the next unique id for each new conversion
    private static int IDCOUNTER = 0;

    // returns the next uniqe id for each new conversion and increments static counter
    private int generateID(){
        return IDCOUNTER++;
    }

    // Initializes the Conversion with its name and its two buttons to perfom unit conversions.
    public Conversion(String name, ConversionButton leftButton, ConversionButton rightButton){
        this.id = generateID();
        this.name = name;
        this.leftButton = leftButton;
        this.rightButton = rightButton;
    }

    // public accessor for id
    public int getId(){
        return this.id;
    }

    // Public accessor for name
    public String getName(){
        return this.name;
    }

    // Public accessor for LeftButton
    public ConversionButton getLeftButton(){
        return this.leftButton;
    }

    // Public accessor for RightButton
    public ConversionButton getRightButton(){
        return this.rightButton;
    }

    // Helper method to generate all available conversions.  To add a conversion, simply instantiate
    // a new Conversion object and append to the ArrayList.
    public static ArrayList<Conversion> generateConversions(){

        // Initialize all the conversions
        Conversion areaConversion = new Conversion("Area",
                new ConversionButton("ha to ac", (Double value) -> { return value * 2.471; }),
                new ConversionButton("ac to ha", (Double value) -> { return value * 0.405; }));

        Conversion tempConversion = new Conversion("Temperature",
                new ConversionButton("C to F", (Double value) -> { return value * 9.0 / 5.0 + 32.0; }),
                new ConversionButton("F to C", (Double value) -> { return (value - 32.0) * 5.0 / 9.0; }));

        Conversion lengthConversion = new Conversion("Length",
                new ConversionButton("ft to m", (Double value) -> { return value * 0.305; }),
                new ConversionButton("m to ft", (Double value) -> { return value * 3.281; }));

        Conversion weightConversion = new Conversion("Weight",
                new ConversionButton("lbs to kg", (Double value) -> { return value * 0.454; }),
                new ConversionButton("kg to lbs", (Double value) -> { return value * 2.205; }));

        // Store all conversions together
        ArrayList<Conversion> conversions = new ArrayList<>();
        conversions.add(areaConversion);
        conversions.add(tempConversion);
        conversions.add(lengthConversion);
        conversions.add(weightConversion);

        return conversions;
    }
}