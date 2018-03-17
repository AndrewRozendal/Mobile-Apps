package ca.camosun.lab6converter;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

public class MainActivity extends Activity implements AdapterView.OnItemSelectedListener {
    // Holds all the available conversions
    private Hashtable<String, Conversion> conversions;
    // the left button
    private Button leftButton;
    // the right button
    private Button rightButton;
    // the current conversion
    private Conversion selectedConversion;

    // Interface for all button conversion actions to conform to
    private interface PerformsConversion {
        Double convert(Double value);
    }

    // A button that belongs to a Conversion
    private class ConversionButton{
        // the text label to display for the button
        String name;
        // the lambda expression to call on button click
        PerformsConversion action;

        // Initializes the ConversionButton with the name and action.  The action must conform to
        // the PerformsConversion interface.
        public ConversionButton(String buttonName, PerformsConversion action){
            this.name = buttonName;
            this.action = action;
        }
    }

    // A Conversion that can be performed.  Contains two buttons to provide conversions between two
    // different units of measurement in both directions
    private class Conversion {
        // the name to display for the conversion
        String name;
        // the left button
        ConversionButton leftButton;
        // the right button
        ConversionButton rightButton;

        // Initializes the Conversion with its name and its two buttons to perfom unit conversions.
        public Conversion(String name, ConversionButton leftButton, ConversionButton rightButton){
            this.name = name;
            this.leftButton = leftButton;
            this.rightButton = rightButton;
        }
    }

    // An item was selected in the Spinner.  Detect choice and update UI and instance variables.
    public void onItemSelected(AdapterView<?> parent, View view,
                               int pos, long id) {
        if(conversions.isEmpty()){
            // there are no conversions to use
            throw new NullPointerException("Conversions was not instantiated yet.");
        }

        // Get selected item and update the current conversion instance
        String selectedConversionName = parent.getItemAtPosition(pos).toString();
        selectedConversion = conversions.get(selectedConversionName);

        if(selectedConversion == null){
            // selectedConversion was not set up properly
            throw new NullPointerException("Desired conversion was not found.");
        }

        if(leftButton == null){
            // left button was not set up properly
            throw new NullPointerException("Left button was not set");
        }

        if(rightButton == null){
            // right button was not set up properly
            throw new NullPointerException("Right button was not set");
        }

        // update each button's text
        leftButton.setText(selectedConversion.leftButton.name);
        rightButton.setText(selectedConversion.rightButton.name);

    }

    // When nothing is selected.  OnItemSelectedListener requires us to implement this
    public void onNothingSelected(AdapterView<?> parent) {
        // Another interface callback
        return;
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

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

        // Store all the conversions for later reference
        conversions = new Hashtable<>();
        conversions.put(areaConversion.name, areaConversion);
        conversions.put(tempConversion.name, tempConversion);
        conversions.put(lengthConversion.name, lengthConversion);
        conversions.put(weightConversion.name, weightConversion);

        // Get a list of all conversion names for the spinner to use
        List<String> conversionNames = new ArrayList<>();
        conversionNames.add(areaConversion.name);
        conversionNames.add(tempConversion.name);
        conversionNames.add(lengthConversion.name);
        conversionNames.add(weightConversion.name);

        // Setup the spinner with conversion names
        Spinner conversionsSpinner = (Spinner) findViewById(R.id.conversionsSpinner);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.support_simple_spinner_dropdown_item, conversionNames);
        conversionsSpinner.setAdapter(adapter);

        // Ensure spinner calls us back on item selection
        conversionsSpinner.setOnItemSelectedListener(this);

        // Grab references for later use by the spinner
        leftButton = (Button) findViewById(R.id.leftButton);
        rightButton = (Button) findViewById(R.id.rightButton);
    }

    // Called when the left button was clicked.  Converts using the currently selected conversion
    // from the conversion spinner.
    public void leftButton(View view){
        if(selectedConversion == null){
            // selected conversion was never set properly
            throw new NullPointerException("selectedConversion was not set properly");
        }

        // Grab the user variable
        EditText converterField = (EditText) findViewById(R.id.userVariable);

        try {
            // Throws if Null or no Double found
            double temp = Double.parseDouble(converterField.getText().toString());

            // Convert the user variable and output the result
            double convertedTemp = selectedConversion.leftButton.action.convert(temp);
            converterField.setText(Double.toString(convertedTemp));
        } catch (NullPointerException NumberFormatException){
            converterField.setText("N/A");
        }

    }

    // Called when the right button was clicked.  Converts using the currently selected conversion
    // from the conversion spinner.
    public void rightButton(View view){
        if(selectedConversion == null){
            // selected conversion was never set properly
            throw new NullPointerException("selectedConversion was not set properly");
        }

        // Grab the user variable
        EditText converterField = (EditText) findViewById(R.id.userVariable);

        try {
            // Throws if Null or no Double found
            double temp = Double.parseDouble(converterField.getText().toString());

            // Convert the user variable and output the result
            double convertedTemp = selectedConversion.rightButton.action.convert(temp);
            converterField.setText(Double.toString(convertedTemp));
        } catch (NullPointerException NumberFormatException){
            converterField.setText("N/A");
        }

    }
}
