package visao;

import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.input.ScrollEvent;
import javafx.scene.layout.StackPane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import persistencia.ImageReader;
import javafx.geometry.Pos;

import java.io.File;

public class ImageShow {
    private double scaleFactor = 1.0;
    private double lastX, lastY;
    
    
    public void imShow(int[][][] im, String file_path) {
		ImageReader.imWrite(im, file_path.split("\\.")[0] + "_temp.png");
		imShow(new File(file_path.split("\\.")[0] + "_temp.png"));
    }
    
    public void imShow(int[][] im, String file_path) {
		ImageReader.imWrite(im, file_path.split("\\.")[0] + "_temp.png");
		imShow(new File(file_path.split("\\.")[0] + "_temp.png"));
    }
    
    public void imShow(int[][] im, String file_path, String nameScreen) {
		ImageReader.imWrite(im, file_path.split("\\.")[0] + "_temp.png");
		imShow(new File(file_path.split("\\.")[0] + "_temp.png"), nameScreen);
    }
    
    public void imShow(boolean[][] im, String file_path) {
		ImageReader.imWrite(im, file_path.split("\\.")[0] + "_temp.png");
		imShow(new File(file_path.split("\\.")[0] + "_temp.png"));
    }

    public void imShow(File file) {
        Stage modalStage = new Stage();
        modalStage.initModality(Modality.APPLICATION_MODAL);
        modalStage.setTitle("ImageShow");

        ImageView fullImageView = new ImageView(new Image(file.toURI().toString()));
        fullImageView.setPreserveRatio(true);

        StackPane modalRoot = new StackPane();
        modalRoot.getChildren().add(fullImageView);
        modalRoot.setAlignment(Pos.CENTER);

        // Handle zooming with scroll
        fullImageView.setOnScroll(new EventHandler<ScrollEvent>() {
            @Override
            public void handle(ScrollEvent event) {
                double deltaY = event.getDeltaY();
                double zoomFactor = 1.05;

                if (deltaY < 0) {
                    scaleFactor /= zoomFactor;
                } else {
                    scaleFactor *= zoomFactor;
                }

                fullImageView.setScaleX(scaleFactor);
                fullImageView.setScaleY(scaleFactor);

                event.consume();
            }
        });

        // Handle panning with drag
        fullImageView.setOnMousePressed(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent event) {
                lastX = event.getSceneX();
                lastY = event.getSceneY();
            }
        });

        fullImageView.setOnMouseDragged(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent event) {
                double deltaX = event.getSceneX() - lastX;
                double deltaY = event.getSceneY() - lastY;

                fullImageView.setTranslateX(fullImageView.getTranslateX() + deltaX);
                fullImageView.setTranslateY(fullImageView.getTranslateY() + deltaY);

                lastX = event.getSceneX();
                lastY = event.getSceneY();
            }
        });

        Scene modalScene = new Scene(modalRoot, 500, 500);
        modalStage.setScene(modalScene);
        modalStage.show();
    }
    
    public void imShow(File file, String nameScreen) {
        Stage modalStage = new Stage();
        modalStage.initModality(Modality.APPLICATION_MODAL);
        modalStage.setTitle(nameScreen);

        ImageView fullImageView = new ImageView(new Image(file.toURI().toString()));
        fullImageView.setPreserveRatio(true);

        StackPane modalRoot = new StackPane();
        modalRoot.getChildren().add(fullImageView);
        modalRoot.setAlignment(Pos.CENTER);

        // Handle zooming with scroll
        fullImageView.setOnScroll(new EventHandler<ScrollEvent>() {
            @Override
            public void handle(ScrollEvent event) {
                double deltaY = event.getDeltaY();
                double zoomFactor = 1.05;

                if (deltaY < 0) {
                    scaleFactor /= zoomFactor;
                } else {
                    scaleFactor *= zoomFactor;
                }

                fullImageView.setScaleX(scaleFactor);
                fullImageView.setScaleY(scaleFactor);

                event.consume();
            }
        });

        // Handle panning with drag
        fullImageView.setOnMousePressed(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent event) {
                lastX = event.getSceneX();
                lastY = event.getSceneY();
            }
        });

        fullImageView.setOnMouseDragged(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent event) {
                double deltaX = event.getSceneX() - lastX;
                double deltaY = event.getSceneY() - lastY;

                fullImageView.setTranslateX(fullImageView.getTranslateX() + deltaX);
                fullImageView.setTranslateY(fullImageView.getTranslateY() + deltaY);

                lastX = event.getSceneX();
                lastY = event.getSceneY();
            }
        });

        Scene modalScene = new Scene(modalRoot, 500, 500);
        modalStage.setScene(modalScene);
        modalStage.show();
    }
}
