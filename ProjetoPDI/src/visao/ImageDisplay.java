package visao;

import javafx.scene.control.ScrollPane;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.TilePane;

import java.io.File;
import java.util.List;

public class ImageDisplay {
    private TilePane imageGrid = new TilePane(10, 10);
    private ImageShow imageModal = new ImageShow();

    private void addImageToGrid(File file) {
        ImageView imageView = new ImageView(new Image(file.toURI().toString()));
        imageView.setFitHeight(100);
        imageView.setPreserveRatio(true);

        imageView.setOnMouseClicked(event -> imageModal.imShow(file));

        imageGrid.getChildren().add(imageView);
    }

    public ScrollPane createImageGridScrollPane() {
        ScrollPane scrollPane = new ScrollPane(imageGrid);
        scrollPane.setFitToWidth(true);
        scrollPane.setFitToHeight(true);
        return scrollPane;
    }

    public void loadImages(List<File> selectedFiles) {
        imageGrid.getChildren().clear();
        for (File file : selectedFiles) {
            addImageToGrid(file);
        }
    }

    public void clearImages() {
        imageGrid.getChildren().clear();
    }
}
