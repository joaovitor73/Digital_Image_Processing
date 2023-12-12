package visao;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.TableColumn;
import javafx.scene.control.Button;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

import java.io.File;
import java.lang.reflect.Field;
import java.util.List;

import dominio.Entity;

public class DataTableView {
    private ImageShow imageShow = new ImageShow();

	List<Entity> entities;
	public DataTableView(List<Entity> entities) {
		this.entities = entities;
	}
	
    public void displayDataTable() {
        Stage stage = new Stage();
        stage.setTitle("Tabela de Dados");

        TableView<Entity> tableView = new TableView<>();

        Class<?> entityClass = Entity.class;
        for (Field field : entityClass.getDeclaredFields()) {
            if (field.getType() == Double.class || field.getType() == double.class) {
                TableColumn<Entity, Double> column = new TableColumn<>(field.getName());
                column.setCellValueFactory(new PropertyValueFactory<>(field.getName()));
                tableView.getColumns().add(column);
            } else { 
	            if (field.getType() == String.class) {
	                TableColumn<Entity, String> column = new TableColumn<>(field.getName());
	                column.setCellValueFactory(new PropertyValueFactory<>(field.getName()));
                    if(field.getName() == "image") {                    	
    	                column.setCellFactory(param -> new FileTableCell());
                    }
	                tableView.getColumns().add(column);	                	
	            }
            }
        }

        ObservableList<Entity> data = FXCollections.observableArrayList(entities);
        tableView.setItems(data);

        // Create a layout and set the scene
        VBox layout = new VBox(10);
        layout.setPadding(new Insets(10));
        layout.getChildren().add(tableView);

        Scene scene = new Scene(layout, 300, 200);
        stage.setScene(scene);

        // Show the stage
        stage.show();
    }

    private class FileTableCell extends TableCell<Entity, String> {
        @Override
        protected void updateItem(String file, boolean empty) {
            super.updateItem(file, empty);
            if (empty || file == null) {
                setText(null);
            } else {
                // Create a button or hyperlink to open the ImageShow window
                Button openImageButton = new Button("Abrir Imagem");
                openImageButton.setOnAction(event -> {
                    // Handle opening ImageShow window with the selected file
                    File the_file = new File(file);
                	imageShow.imShow(the_file);
                });

                setGraphic(openImageButton);
            }
        }
    }
}
