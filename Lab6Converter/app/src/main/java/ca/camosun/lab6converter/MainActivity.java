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
    private Hashtable<String, Conversion> conversions;
    private Button leftButton;
    private Button rightButton;
    private Conversion selectedConversion;


    private interface PerformsConversion {
        Double convert(Double value);
    }

    private class ConversionButton{
        String name;
        PerformsConversion action;
        public ConversionButton(String buttonName, PerformsConversion action){
            this.name = buttonName;
            this.action = action;
        }
    }

    private class Conversion {
        String name;
        ConversionButton leftButton;
        ConversionButton rightButton;

        public Conversion(String name, ConversionButton leftButton, ConversionButton rightButton){
            this.name = name;
            this.leftButton = leftButton;
            this.rightButton = rightButton;
        }
    }


    public void onItemSelected(AdapterView<?> parent, View view,
                               int pos, long id) {
        if(conversions.isEmpty()){
            throw new NullPointerException("Conversions was not instantiated yet.");
        }
        // An item was selected. You can retrieve the selected item using
        System.out.println("item selected detected");
        String selectedConversionName = parent.getItemAtPosition(pos).toString();
        selectedConversion = conversions.get(selectedConversionName);
        if(selectedConversion == null){
            //Error!
            throw new NullPointerException("Desired conversion was not found.");
        }

        if(leftButton == null){
            throw new NullPointerException("Left button was not set");
        }

        if(rightButton == null){
            throw new NullPointerException("Right button was not set");
        }

        leftButton.setText(selectedConversion.leftButton.name);
        rightButton.setText(selectedConversion.rightButton.name);

    }

    public void onNothingSelected(AdapterView<?> parent) {
        // Another interface callback
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Initialize all the conversions

        //ConversionSpinnerActivity spinner = new ConversionSpinnerActivity();

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

        conversions = new Hashtable<>();
        conversions.put(areaConversion.name, areaConversion);
        conversions.put(tempConversion.name, tempConversion);
        conversions.put(lengthConversion.name, lengthConversion);
        conversions.put(weightConversion.name, weightConversion);

        Spinner conversionsSpinner = (Spinner) findViewById(R.id.conversionsSpinner);

        List<String> conversionNames = new ArrayList<>();
        conversionNames.add(areaConversion.name);
        conversionNames.add(tempConversion.name);
        conversionNames.add(lengthConversion.name);
        conversionNames.add(weightConversion.name);

        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.support_simple_spinner_dropdown_item, conversionNames);
        conversionsSpinner.setAdapter(adapter);
        conversionsSpinner.setOnItemSelectedListener(this);

        leftButton = (Button) findViewById(R.id.leftButton);
        leftButton.setText("");
        rightButton = (Button) findViewById(R.id.rightButton);
        rightButton.setText("");

    }

    public void leftButton(View view){
        if(selectedConversion == null){
            throw new NullPointerException("selectedConversion was not set properly");
        }
        EditText converterField = (EditText) findViewById(R.id.userVariable);
        double temp = Double.parseDouble(converterField.getText().toString());
        double convertedTemp = selectedConversion.leftButton.action.convert(temp);
        converterField.setText(Double.toString(convertedTemp));
    }

    public void rightButton(View view){
        if(selectedConversion == null){
            throw new NullPointerException("selectedConversion was not set properly");
        }
        EditText converterField = (EditText) findViewById(R.id.userVariable);
        double temp = Double.parseDouble(converterField.getText().toString());
        double convertedTemp = selectedConversion.rightButton.action.convert(temp);
        converterField.setText(Double.toString(convertedTemp));
    }
}
