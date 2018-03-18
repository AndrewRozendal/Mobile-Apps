package ca.camosun.lab6converter;

// A button that belongs to a Conversion
public class ConversionButton{
    // the text label to display for the button
    private String name;
    // the lambda expression to call on button click
    private PerformsConversion action;

    // Initializes the ConversionButton with the name and action.  The action must conform to
    // the PerformsConversion interface.  The action is a lambda expression for use later.
    public ConversionButton(String buttonName, PerformsConversion action){
        this.name = buttonName;
        this.action = action;
    }

    // Public accessor for name
    public String getName(){
        return this.name;
    }

    // Public accessor for action
    public PerformsConversion getAction(){
        return this.action;
    }
}
