package UI;

import UI.LoginForm;
import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.border.MatteBorder;
import java.awt.Color;
import javax.swing.SwingConstants;
import java.awt.Font;
import javax.swing.JTextField;
import com.toedter.calendar.JDateChooser;

import common.ConnecToProperties;
import entity.LendingHistory;

import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.awt.event.ActionEvent;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.JPasswordField;

public class MemberPage extends JFrame {
	private JPanel contentPane;
	private JFrame frame;
	private JTextField txtPoint;
	private JTable tableHistory;
	public static JTextField txtNo;
	private JTextField txtuserName;
	private JTextField txtID;
	private JDateChooser joiningDateChooser;
	private JDateChooser expiryDateChooser;
	private String no;
	
	/**
	 * Launch the application.
	 */
	public ArrayList<LendingHistory> historiesList(){
		ArrayList<LendingHistory> historiesList = new ArrayList<>();
		try (
				var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
		) {
			System.out.println("Successfully Connected!");
			String queryDisplay = "Select * from Account where AccountName=? and Password=?";
			PreparedStatement pst = connection.prepareStatement(queryDisplay);
			pst.setString(1, LoginForm.username.getText());
			pst.setString(2, LoginForm.passwordField.getText());
			ResultSet rsDisplay = pst.executeQuery();
			
			if(rsDisplay.next()){
				no = rsDisplay.getString("AccountNo");
				txtNo.setText(no);
				txtuserName.setText(rsDisplay.getString("AccountName"));
				txtID.setText(rsDisplay.getString("LibraryID"));
				joiningDateChooser.setDate(rsDisplay.getDate("DJoined"));
				expiryDateChooser.setDate(rsDisplay.getDate("DExpired"));
				txtPoint.setText(rsDisplay.getString("Points"));
			}
			
			//table
			String queryTable = "SELECT * FROM LendingHistory where AccountNo="+no;
			Statement st = connection.createStatement();
			ResultSet rsTable = st.executeQuery(queryTable);
			LendingHistory history;
			while(rsTable.next()) {
				history = new LendingHistory(rsTable.getInt("LendNo"), rsTable.getInt("ItemNo"), rsTable.getDate("DIssued"), rsTable.getDate("DReturned"), rsTable.getBoolean("Status"));
				historiesList.add(history);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return historiesList;
	}
	
	public void show_history() {
		ArrayList<LendingHistory> list = historiesList();
		DefaultTableModel model = (DefaultTableModel) tableHistory.getModel();
		Object[] row = new Object[5];
		String status = "Enable";
		for(int i=0; i<list.size(); i++) {
			row[0] = i + 1;
			row[1] = list.get(i).getItemNo();
			row[2] = list.get(i).getDIssued();
			row[3] = list.get(i).getDReturned();
			if (list.get(i).getStatus().equals("false")) {
				status = "Disable";
			}
			row[4] = status;
			model.addRow(row);
		}
	}
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					MemberPage frame = new MemberPage();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	/**
	 * Create the frame.
	 */
	
	public MemberPage() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(320, 180, 900, 555);
		contentPane = new JPanel();
		contentPane.setBackground(new Color(220, 220, 220));
		contentPane.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(220, 220, 220));
		panel.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel.setBounds(10, 10, 880, 31);
		contentPane.add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("LIBRARY SYSTEM");
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 20));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setBounds(0, 0, 880, 31);
		panel.add(lblNewLabel);
		
		JPanel panel_1 = new JPanel();
		panel_1.setBounds(10, 40, 250, 454);
		contentPane.add(panel_1);
		panel_1.setLayout(null);
		panel_1.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_1.setBackground(new Color(220, 220, 220));
		
		JLabel lblNewLabel_1 = new JLabel("Account No");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblNewLabel_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1.setBounds(10, 50, 100, 15);
		panel_1.add(lblNewLabel_1);
		
		JLabel lblNewLabel_1_1 = new JLabel("Username");
		lblNewLabel_1_1.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblNewLabel_1_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_1.setBounds(10, 120, 100, 15);
		panel_1.add(lblNewLabel_1_1);
		
		JLabel lblNewLabel_1_2 = new JLabel("Library ID");
		lblNewLabel_1_2.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblNewLabel_1_2.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_2.setBounds(10, 203, 100, 15);
		panel_1.add(lblNewLabel_1_2);
		
		JLabel lblNewLabel_1_3 = new JLabel("Joining Date");
		lblNewLabel_1_3.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblNewLabel_1_3.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_3.setBounds(10, 260, 100, 15);
		panel_1.add(lblNewLabel_1_3);
		
		JLabel lblNewLabel_1_4 = new JLabel("Expiry Date");
		lblNewLabel_1_4.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblNewLabel_1_4.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_4.setBounds(10, 320, 100, 15);
		panel_1.add(lblNewLabel_1_4);
		
		JLabel lblNewLabel_1_5 = new JLabel("Point");
		lblNewLabel_1_5.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblNewLabel_1_5.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_5.setBounds(10, 380, 100, 15);
		panel_1.add(lblNewLabel_1_5);
		
		txtPoint = new JTextField();
		txtPoint.setEnabled(false);
		txtPoint.setColumns(10);
		txtPoint.setBounds(10, 406, 215, 20);
		panel_1.add(txtPoint);
		
		joiningDateChooser = new JDateChooser();
		joiningDateChooser.setBounds(10, 289, 215, 20);
		panel_1.add(joiningDateChooser);
		joiningDateChooser.setEnabled(false);
		
		expiryDateChooser = new JDateChooser();
		expiryDateChooser.setBounds(10, 346, 215, 20);
		panel_1.add(expiryDateChooser);
		expiryDateChooser.setEnabled(false);
		
		JLabel lblNewLabel_2 = new JLabel("ACCOUNT INFO");
		lblNewLabel_2.setForeground(new Color(255, 255, 255));
		lblNewLabel_2.setFont(new Font("Tahoma", Font.BOLD, 20));
		lblNewLabel_2.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel_2.setBounds(10, 11, 215, 28);
		panel_1.add(lblNewLabel_2);
		
		txtNo = new JTextField();
		txtNo.setEnabled(false);
		
		txtNo.setColumns(10);
		txtNo.setBounds(10, 76, 215, 20);
		panel_1.add(txtNo);
		
		txtuserName = new JTextField();
		txtuserName.setEnabled(false);
		txtuserName.setColumns(10);
		txtuserName.setBounds(10, 158, 215, 20);
		panel_1.add(txtuserName);
		
		txtID = new JTextField();
		txtID.setEnabled(false);
		txtID.setColumns(10);
		txtID.setBounds(10, 229, 215, 20);
		panel_1.add(txtID);
		
		JPanel panel_2 = new JPanel();
		panel_2.setLayout(null);
		panel_2.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_2.setBackground(new Color(220, 220, 220));
		panel_2.setBounds(260, 40, 630, 454);
		contentPane.add(panel_2);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(10, 44, 610, 399);
		panel_2.add(scrollPane);
		
		tableHistory = new JTable();
		tableHistory.setModel(new DefaultTableModel(
			new Object[][] {
			},
			new String[] {
				"No", "Item No", "Day Issued", "Day Returned", "Status"
			}
		));
		tableHistory.getColumnModel().getColumn(3).setPreferredWidth(86);
		scrollPane.setViewportView(tableHistory);
		
		JLabel lblHistory = new JLabel("HISTORY");
		lblHistory.setForeground(new Color(255, 255, 255));
		lblHistory.setFont(new Font("Tahoma", Font.BOLD, 20));
		lblHistory.setHorizontalAlignment(SwingConstants.CENTER);
		lblHistory.setBounds(10, 11, 610, 28);
		panel_2.add(lblHistory);
		
		JPanel panel_3 = new JPanel();
		panel_3.setLayout(null);
		panel_3.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_3.setBackground(new Color(220, 220, 220));
		panel_3.setBounds(10, 494, 880, 50);
		contentPane.add(panel_3);
		
		JButton btnNewButton = new JButton("CHANGE PASSWORD");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) {
					System.out.println("Successfully Connected!");
					String response;
					response = JOptionPane.showInputDialog("Please Enter Your New Password");
					
					String pass = response;
					System.out.println(pass);
					String queryChange = "UPDATE Account SET Password=? where AccountNo=" + no;

					PreparedStatement pst = connection.prepareStatement(queryChange);
					pst.setString(1, pass);
					pst.executeUpdate();
					JOptionPane.showInternalMessageDialog(null, "Successful password reset!");
				} catch (SQLException err) {
					System.out.println(err.getMessage());
				}
			}
		});
		btnNewButton.setForeground(new Color(255, 255, 255));
		btnNewButton.setBackground(new Color(0, 128, 0));
		btnNewButton.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnNewButton.setBounds(252, 11, 220, 23);
		panel_3.add(btnNewButton);
		
		JButton btnClose = new JButton("LOGOUT");
		btnClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				LoginForm field = new LoginForm();
				field.setVisible(true);
				setVisible(false);
			}
		});
		btnClose.setForeground(new Color(255, 255, 255));
		btnClose.setBackground(new Color(112, 128, 144));
		btnClose.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnClose.setBounds(530, 11, 100, 23);
		panel_3.add(btnClose);
		
		show_history();
		setUndecorated(true);
	}
}
