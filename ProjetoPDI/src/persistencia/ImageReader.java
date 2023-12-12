package persistencia;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class ImageReader {
	/**
     * Classe abstrata ImageReader, que fornece métodos para leitura e escrita de imagens.
     * Esta classe depende do Java 11.
     * 
     * @author Luan Magioli e Yuri Felipe
     * @version 1.0
     */
	
	/**
     * O método imRead é usado para ler uma imagem de um arquivo e retornar um array tridimensional de inteiros.
     *
     * @param path O caminho para o arquivo de imagem.
     * @return Retorna o array tridimensional de inteiros representando uma imagem colorida.
     */
    public static int[][][] imRead(String path) {
        try {
            BufferedImage im = ImageIO.read(new File(path));
            
            int[][][] imMatrix = bufferedImage2Image(im);

            System.out.println("Image '"+path+"' loaded successfully!");
            return imMatrix;
        } catch (IOException e) {
            System.out.println("Loading error: Please verify that the specified path exists and try again.");
        }
        return null;
    }
    
    
    /**
     * O método imRead é usado para ler uma imagem de um arquivo e retornar um array tridimensional de inteiros.
     *
     * @param path O caminho para o arquivo de imagem.
     * @return Retorna o array tridimensional de inteiros representando uma imagem colorida.
     */
    public static int[][][] imRead(File file) {
        try {
            BufferedImage im = ImageIO.read(file);
            
            int[][][] imMatrix = bufferedImage2Image(im);

            System.out.println("Image '"+file.getName()+"' loaded successfully!");
            return imMatrix;
        } catch (IOException e) {
            System.out.println("Loading error: Please verify that the specified path exists and try again.");
        }
        return null;
    }

    
    /**
     * O método bufferedImage2Image é usado para converter um objeto BufferedImage em um array tridimensional de inteiros.
     *
     * @param im Objeto BufferedImage para converter.
     * @return Retorna o array tridimensional de inteiros representando a imagem colorida.
     */
    public static int[][][] bufferedImage2Image(BufferedImage im) {
        int[][][] imMatrix = new int[im.getHeight()][im.getWidth()][3];
        for (int i = 0; i < im.getHeight() - 1; i++) {
            for (int j = 0; j < im.getWidth() - 1; j++) {
                int rgb = im.getRGB(j, i);
                imMatrix[i][j][0] = (rgb & 0x00FF0000) >>> 16; // R
                imMatrix[i][j][1] = (rgb & 0x0000FF00) >>> 8; // G
                imMatrix[i][j][2] = rgb & 0x000000FF; // B
            }
        }

        return imMatrix;
    }

    /**
     * O método image2BufferedImage é usado para converter um array tridimensional de inteiros em um objeto BufferedImage.
     *
     * @param im Array tridimensional de inteiros para converter.
     * @return Retorna o objeto BufferedImage representando a imagem colorida.
     */
    public static BufferedImage image2BufferedImage(int[][][] im) {
        BufferedImage buff = new BufferedImage(im[0].length, im.length, BufferedImage.TYPE_INT_RGB);

        for (int i = 0; i < im.length; i++) {
            for (int j = 0; j < im[0].length; j++) {
                Color color = new Color(im[i][j][0], im[i][j][1], im[i][j][2]);
                buff.setRGB(j, i, color.getRGB());
            }
        }
        return buff;
    }

    /**
     * O método image2BufferedImage é usado para converter um array bidimensional de inteiros em um objeto BufferedImage.
     *
     * @param im Array bidimensional de inteiros para converter.
     * @return Retorna o objeto BufferedImage representando a imagem em escala de cinza.
     */
    public static BufferedImage image2BufferedImage(int[][] im) {
        BufferedImage buff = new BufferedImage(im[0].length, im.length, BufferedImage.TYPE_INT_RGB);

        for (int i = 0; i < im.length; i++) {
            for (int j = 0; j < im[0].length; j++) {
                if (im[i][j] < 0)
                    im[i][j] = 0;
                if (im[i][j] > 255)
                    im[i][j] = 255;

                Color color = new Color(im[i][j], im[i][j], im[i][j]);
                buff.setRGB(j, i, color.getRGB());
            }
        }
        return buff;
    }

    /**
     * O método image2BufferedImage é usado para converter um array bidimensional de valores lógicos em um objeto BufferedImage.
     *
     * @param im Array bidimensional de booleans para converter.
     * @return Retorna o objeto BufferedImage representando a imagem binária.
     */
    public static BufferedImage image2BufferedImage(boolean[][] im) {
        BufferedImage buff = new BufferedImage(im[0].length, im.length, BufferedImage.TYPE_INT_RGB);
        int val;
        for (int i = 0; i < im.length; i++) {
            for (int j = 0; j < im[0].length; j++) {
                if (im[i][j])
                    val = 255;
                else
                    val = 0;

                Color color = new Color(val, val, val);
                buff.setRGB(j, i, color.getRGB());
            }
        }
        return buff;
    }

    /**
     * O método imWrite é usado para salvar uma imagem de um objeto BufferedImage para um arquivo. 
     *
     * @param path O caminho para o arquivo de imagem.
     * @param bufferedImage O objeto BufferedImage para salvar.
     */
    private static void imWrite(String path, BufferedImage bufferedImage) {
        try {
            BufferedImage buff = bufferedImage;
            String[] type = path.split("\\.");
            ImageIO.write(buff, type[type.length - 1], new File(path));
            System.out.println("Image '"+path+"' successfully written!");
        } catch (IOException e) {
            System.out.println("Writing error: Please verify that the specified path exists and try again.");
        } catch (Exception e) {
            System.out.println("Writing error: " + e.getMessage());
        }
    }

    /**
     * O método imWrite é usado para salvar uma imagem de um array tridimensional de inteiros para um arquivo. 
     *
     * @param im O array tridimensional de inteiros para salvar.
     * @param path O caminho para o arquivo de imagem.
     */
    public static void imWrite(int[][][] im, String path) {
        imWrite(path, image2BufferedImage(im));
    }

    /**
     * O método imWrite é usado para salvar uma imagem de um array bidimensional de inteiros para um arquivo. 
     *
     * @param im O array bidimensional de inteiros para salvar.
     * @param path O caminho para o arquivo de imagem.
     */
    public static void imWrite(int[][] im, String path) {
        imWrite(path, image2BufferedImage(im));
    }

    /**
     * O método imWrite é usado para salvar uma imagem de um array bidimensional de valores lógicos para um arquivo. 
     *
     * @param im O array bidimensional de valores lógicos para salvar.
     * @param path O caminho para o arquivo de imagem.
     */
    public static void imWrite(boolean[][] im, String path) {
        imWrite(path, image2BufferedImage(im));
    }
}
