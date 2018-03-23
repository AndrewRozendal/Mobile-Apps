package ca.camosun.masterdetailconverter;

import java.util.Hashtable;

// A Conversion that can be performed.  Contains two buttons to provide conversions between two
// different units of measurement in both directions
public class Conversion {
    // the name to display for the conversion
    private String name;
    // the left button
    private ConversionButton leftButton;
    // the right button
    private ConversionButton rightButton;

    // Initializes the Conversion with its name and its two buttons to perfom unit conversions.
    public Conversion(String name, ConversionButton leftButton, ConversionButton rightButton){
        this.name = name;
        this.leftButton = leftButton;
        this.rightButton = rightButton;
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
    // a new Conversion object and append to the Hashtable.
    public static Hashtable<String, Conversion> generateConversions(){

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
        Hashtable<String, Conversion> conversions = new Hashtable<>();
        conversions.put(areaConversion.name, areaConversion);
        conversions.put(tempConversion.name, tempConversion);
        conversions.put(lengthConversion.name, lengthConversion);
        conversions.put(weightConversion.name, weightConversion);

        return conversions;
    }
}