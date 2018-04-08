package ca.camosun.androidmoviedatabase;

import android.app.Activity;
import android.content.res.Resources;
import android.os.Bundle;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.v4.app.Fragment;
import android.support.v4.content.res.ResourcesCompat;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RatingBar;
import android.widget.TextView;

import org.w3c.dom.Text;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

import ca.camosun.androidmoviedatabase.movie.Genres;
import ca.camosun.androidmoviedatabase.movie.Movie;
import ca.camosun.androidmoviedatabase.movie.MovieContent;

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
     * The Movie content this fragment is presenting.
     */
    private Movie mItem;

    /**
     * The Button for toggling user Movie favourite
     */
    private Button favButton;

    /**
     * The RatingBar for updating user Movie rating
     */
    private RatingBar ratingBar;


    /**
     * The RatingBar for updating user Movie rating
     */
    private TextView notification;

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
            // Load the Movie content specified by the fragment arguments.
            mItem = MovieContent.ITEM_MAP.get(getArguments().getString(ARG_ITEM_ID));

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

        // Show the Movie content as text in a TextView.
        if (mItem == null) {
            //selected movie was not set correctly
            Log.e("onCreateView", "movie was not set properly");
        }

        // setup the favourite button
        favButton = ((Button) rootView.findViewById(R.id.favouriteButton));
        favButton.setText(updateFavouriteButtonText());
        favButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                favouriteButtonClicked(view);
            }
        });

        // setup the ratingbar
        ratingBar = (RatingBar) rootView.findViewById(R.id.ratingBarDetail);
        ratingBar.setRating(mItem.rating);
        ratingBar.setOnRatingBarChangeListener(new RatingBar.OnRatingBarChangeListener(){
            @Override
            public void onRatingChanged(RatingBar ratingBar, float val, boolean fromUser){
                updateRating(val);
            }
        });

        // setup genres
        TextView genresLabel = (TextView) rootView.findViewById(R.id.genresLabel);
        genresLabel.setText("Genres:");
        TextView genresContent = (TextView) rootView.findViewById(R.id.genresContent);

        String genresString = "";
        List<Genres> movieGenresList = mItem.getGenres();
        for(int i = 0; i < movieGenresList.size(); i++){
            genresString += movieGenresList.get(i);
            if(i < movieGenresList.size() - 1){
                genresString += ", ";
            }
        }

        genresContent.setText(genresString);

        //setup actors
        TextView actorsLabel = (TextView) rootView.findViewById(R.id.actorsLabel);
        actorsLabel.setText("Actors:");
        TextView actorsContent = (TextView) rootView.findViewById(R.id.actorsContent);

        String actorsString = "";
        List<String> actorsList = mItem.getActors();
        for(int i = 0; i < actorsList.size(); i++){
            actorsString += actorsList.get(i);
            if(i < actorsList.size() - 1){
                actorsString += ", ";
            }
        }

        actorsContent.setText(actorsString);

        //setup comments
        TextView commentsLabel = (TextView) rootView.findViewById(R.id.commentsLabel);
        commentsLabel.setText("Comments: ");
        TextView commentsContent = (TextView) rootView.findViewById(R.id.commentsContent);
        commentsContent.setText(mItem.getComments());

        //setup detail label
        TextView detailLabel = (TextView) rootView.findViewById(R.id.detailsLabel);
        detailLabel.setText("Details:");

        // grab a reference to the notification area and init to empty
        notification = (TextView) rootView.findViewById(R.id.notificationArea);
        notification.setText("");

        //setup image
        ImageView movieImage = (ImageView) rootView.findViewById(R.id.movieImage);
        Resources res = getResources();
        movieImage.setImageDrawable(ResourcesCompat.getDrawable(res, mItem.getImageID(), null));

        return rootView;
    }

    // Called when the favourite button was clicked.  Adds or removes the current movie from the
    // user's favourite list
    public void favouriteButtonClicked(View view){
        if(mItem == null){
            // selected movie was never set properly
            // log and abort
            Log.e("favouriteButtonClicked", "movie was not set properly");
            return;
        }

        // Update movie
        if(mItem.isFavourite){
            mItem.isFavourite = false;
            notification.setText("Movie Removed from Favourites!");
        } else{
            mItem.isFavourite = true;
            notification.setText("Movie Added to Favourites!");
        }

        // update button text
        favButton.setText(updateFavouriteButtonText());
    }

    // updates the text for the favourite button depending on the favourite context
    public String updateFavouriteButtonText(){
        if(mItem.isFavourite){
            return "Remove from Favourites";
        } else {
            return "Add to Favourites";
        }
    }

    // updates the rating of the current movie
    public void updateRating(float newRating){
        if(mItem == null){
            // selected movie was never set properly
            // log and abort
            Log.e("updateRating", "movie was not set properly");
            return;
        }

        // update the rating
        mItem.rating = newRating;

        // update the notification area
        notification.setText("Rating Updated!");
    }
}
