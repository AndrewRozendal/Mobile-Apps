package ca.camosun.lab6converter;

import android.app.Activity;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
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

    public class ConversionSpinnerActivity extends Activity implements AdapterView.OnItemSelectedListener {

        public void onItemSelected(AdapterView<?> parent, View view,
                                   int pos, long id) {
            // An item was selected. You can retrieve the selected item using
            parent.getItemAtPosition(pos);
        }

        public void onNothingSelected(AdapterView<?> parent) {
            // Another interface callback
        }
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

        List<Conversion> conversions = new ArrayList<Conversion>();
        conversions.add(areaConversion);
        conversions.add(tempConversion);
        conversions.add(lengthConversion);
        conversions.add(weightConversion);

        Spinner conversionsSpinner = (Spinner) findViewById(R.id.conversionsSpinner);

        List<String> conversionNames = new ArrayList<>();
        conversionNames.add(areaConversion.name);
        conversionNames.add(tempConversion.name);
        conversionNames.add(lengthConversion.name);
        conversionNames.add(weightConversion.name);

        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.support_simple_spinner_dropdown_item, conversionNames);
        conversionsSpinner.setAdapter(adapter);
        //conversionsSpinner.setOnItemSelectedListener(this);

/*
        TextView converterLabel = (TextView) findViewById(R.id.converterLabel);
        converterLabel.setText(tempLabel);
        Button leftButton = (Button) findViewById(R.id.leftButton);
        leftButton.setText(c2fLabel);
        Button rightButton = (Button) findViewById(R.id.rightButton);
        rightButton.setText(f2cLabel);
*/
    }

    public void leftButton(View view){
        EditText converterField = (EditText) findViewById(R.id.userVariable);
        String temp = converterField.getText().toString();
        double convertedTemp = Double.parseDouble(temp) * 9.0 / 5.0 + 32.0;
        converterField.setText(Double.toString(convertedTemp));
    }

    public void rightButton(View view){
        EditText converterField = (EditText) findViewById(R.id.userVariable);
        String temp = converterField.getText().toString();
        double convertedTemp = (Double.parseDouble(temp) - 32.0) * 5.0 / 9.0;
        converterField.setText(Double.toString(convertedTemp));
    }
}
