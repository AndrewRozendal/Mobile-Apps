package ca.camosun.lab6converter;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    final String tempLabel = "Temperature";
    final String c2fLabel = "C to F";
    final String f2cLabel = "F to C";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        TextView converterLabel = (TextView) findViewById(R.id.converterLabel);
        converterLabel.setText(tempLabel);
        Button leftButton = (Button) findViewById(R.id.leftButton);
        leftButton.setText(c2fLabel);
        Button rightButton = (Button) findViewById(R.id.rightButton);
        rightButton.setText(f2cLabel);
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
