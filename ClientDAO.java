package dao;

import models.Client;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ClientDAO - handles all file I/O for clients.txt
 * Format: id|email|password|fullName|phone|weddingDate|budget|weddingLocation
 */
public class ClientDAO {
    private static final String FILE_PATH = System.getProperty("user.home") + "/weddingbliss_data/clients.txt";

    public ClientDAO() {
        ensureFileExists(FILE_PATH);
    }

    private void ensureFileExists(String path) {
        File file = new File(path);
        file.getParentFile().mkdirs();
        if (!file.exists()) {
            try { file.createNewFile(); } catch (IOException e) { e.printStackTrace(); }
        }
    }

    public void addClient(Client client) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(client.toFileString());
            bw.newLine();
        } catch (IOException e) { e.printStackTrace(); }
    }

    public List<Client> getAllClients() {
        List<Client> clients = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] d = line.split("\\|");
                if (d.length >= 8) {
                    clients.add(new Client(d[0], d[1], d[2], d[3], d[4], d[5],
                            Double.parseDouble(d[6]), d[7]));
                }
            }
        } catch (IOException | NumberFormatException e) { e.printStackTrace(); }
        return clients;
    }

    public Client getClientById(String id) {
        for (Client c : getAllClients()) {
            if (c.getId().equals(id)) return c;
        }
        return null;
    }

    public Client getClientByEmail(String email) {
        for (Client c : getAllClients()) {
            if (c.getEmail().equalsIgnoreCase(email)) return c;
        }
        return null;
    }

    public boolean emailExists(String email) {
        return getClientByEmail(email) != null;
    }

    public void updateClient(Client updated) {
        List<Client> clients = getAllClients();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Client c : clients) {
                bw.write(c.getId().equals(updated.getId()) ? updated.toFileString() : c.toFileString());
                bw.newLine();
            }
        } catch (IOException e) { e.printStackTrace(); }
    }

    public void deleteClient(String id) {
        List<Client> clients = getAllClients();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Client c : clients) {
                if (!c.getId().equals(id)) { bw.write(c.toFileString()); bw.newLine(); }
            }
        } catch (IOException e) { e.printStackTrace(); }
    }
}
