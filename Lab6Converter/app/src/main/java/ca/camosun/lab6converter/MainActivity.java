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
        leftButton.setText(selectedConversion.getLeftButton().getName());
        rightButton.setText(selectedConversion.getRightButton().getName());

    }

    // When nothing is selected.  OnItemSelectedListener requires us to implement this
    public void onNothingSelected(AdapterView<?> parent) {
        // Another interface callback
        return;
    }


    // Generates the conversions instance, sets up the spinner and grabs references to the buttons.
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Call helper method to generate all conversions
        // Store all these conversions for later reference
        conversions = Conversion.generateConversions();

        // Get a list of all conversion names for the spinner to use
        List<String> conversionNames = new ArrayList<>();
        for(String key : conversions.keySet()){
            conversionNames.add(key);
        }

        // Setup the spinner with conversion names
        Spinner conversionsSpinner = (Spinner) findViewById(R.id.conversionsSpinner);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(
                this,
                R.layout.support_simple_spinner_dropdown_item,
                conversionNames);

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

        // Call helper method
        convertValue(selectedConversion.getLeftButton().getAction());
    }

    // Called when the right button was clicked.  Converts using the currently selected conversion
    // from the conversion spinner.
    public void rightButton(View view){
        if(selectedConversion == null){
            // selected conversion was never set properly
            throw new NullPointerException("selectedConversion was not set properly");
        }

        // Call helper method
        convertValue(selectedConversion.getRightButton().getAction());
    }

    // Converts the user value using the passed action.  The action is a lambda expression as per
    // the PerformsConversion interface.
    private void convertValue(PerformsConversion action){
        // Grab the user variable
        EditText converterField = (EditText) findViewById(R.id.userVariable);

        try {
            // Throws if Null or no Double found
            double temp = Double.parseDouble(converterField.getText().toString());

            // Convert the user variable and output the result
            double convertedTemp = action.convert(temp);
            converterField.setText(Double.toString(convertedTemp));
        } catch (NullPointerException|NumberFormatException ex){
            // Failed to convert to a double - the value either contained no double or was empty
            converterField.setText("N/A");
        }
    }
}
