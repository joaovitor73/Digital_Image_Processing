package dominio;

public class Entity {
	private double area;
	private double color;
	private String classification;
	private String image;
	
	public Entity(double area, double color, String image, String classification) {
		this.area = area;
		this.color = color;
		this.setImage(image);
		this.setClassification(classification);
	}

	public double getArea() {
		return area;
	}

	public void setArea(double area) {
		this.area = area;
	}

	public double getColor() {
		return color;
	}

	public void setColor(double color) {
		this.color = color;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
}
