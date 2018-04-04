package ca.camosun.androidmoviedatabase;

import android.app.Activity;
import android.os.Bundle;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;

import ca.camosun.androidmoviedatabase.conversion.Conversion;
import ca.camosun.androidmoviedatabase.conversion.ConversionContent;
import ca.camosun.androidmoviedatabase.conversion.PerformsConversion;

/**
 * A fragment representing a single Item detail screen.
 * This fragment is either contained in a {@link ItemListActivity}
 * in two-pane mode (on tablets) or a {@link ItemDetailActivity}
 * on handsets.
 */
public class ItemDetailFragment extends Fragment {
    /**
     * The fragment argument representing the item ID that this fragment
     * represents.
     */
    public static final String ARG_ITEM_ID = "item_id";

    /**
     * The Conversion content this fragment is presenting.
     */
    private Conversion mItem;

    /**
     * Mandatory empty constructor for the fragment manager to instantiate the
     * fragment (e.g. upon screen orientation changes).
     */
    public ItemDetailFragment() {
    }

    // Setup the current activity from a savedInstanceState
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (getArguments().containsKey(ARG_ITEM_ID)) {
            // Load the Conversion content specified by the fragment arguments.
            mItem = ConversionContent.ITEM_MAP.get(getArguments().getString(ARG_ITEM_ID));

            Activity activity = this.getActivity();
            CollapsingToolbarLayout appBarLayout = (CollapsingToolbarLayout) activity.findViewById(R.id.toolbar_layout);
            if (appBarLayout != null) {
                appBarLayout.setTitle(mItem.getName());
            }
        }
    }

    // Setup the activity as a new view.  This handles first time navigation to this page.
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.item_detail, container, false);

        // Show the Conversion content as text in a TextView.
        if (mItem != null) {
            // setup reference to userInputValue
            EditText userValueField = rootView.findViewById(R.id.userInputValue);

            // setup the conversion buttons with their name, listener and action
            Button leftButton = ((Button) rootView.findViewById(R.id.leftButton));
            leftButton.setText(mItem.getLeftButton().getName());
            leftButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    leftButton(view);
                }
            });

            Button rightButton = ((Button) rootView.findViewById(R.id.rightButton));
            rightButton.setText(mItem.getRightButton().getName());
            rightButton.setOnClickListener(new View.OnClickListener(){
                @Override
                public void onClick(View view) {
                    rightButton(view);
                }
            });
        }

        return rootView;
    }

    // Called when the left button was clicked.  Converts using the currently selected conversion
    // from the conversion spinner.
    public void leftButton(View view){
        if(mItem == null){
            // selected conversion was never set properly
            // log and abort
            Log.e("leftButton", "selectedConversion was not set properly");
            return;
        }

        // Call helper method
        convertValue(mItem.getLeftButton().getAction());
    }

    // Called when the right button was clicked.  Converts using the currently selected conversion
    // from the conversion spinner.
    public void rightButton(View view){
        if(mItem == null){
            // selected conversion was never set properly
            // log and abort
            Log.e("rightButton", "selectedConversion was not set properly");
            return;
        }

        // Call helper method
        convertValue(mItem.getRightButton().getAction());
    }

    // Converts the user value using the passed action.  The action is a lambda expression as per
    // the PerformsConversion interface.
    private void convertValue(PerformsConversion action){
        // Grab the user variable
        EditText converterField = (EditText) this.getActivity().findViewById(R.id.userInputValue);

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
