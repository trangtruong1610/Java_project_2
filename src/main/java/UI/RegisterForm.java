package UI;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import common.ConnectToProperties;

import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Color;
import javax.swing.SwingConstants;
import java.awt.Font;
import javax.swing.JTextField;
import javax.swing.border.BevelBorder;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.awt.Cursor;
import com.toedter.calendar.JDateChooser;

public class RegisterForm extends JFrame {

	private JPanel contentPane;
	private JTextField username;
	private JTextField id;
	private JTextField password;
	private JLabel lblRegister;
	private JLabel lblNewLabel_1;
	private JLabel lblNewLabel_2;
	private JLabel lblNewLabel_3;
	private JLabel lblNewLabel_4;
	private JLabel lblNewLabel_5;
	private JTextField txtSubmit;
	private JTextField txtReset;
	private JLabel lblNewLabel_6;
	private JLabel lblNewLabel_7;
	private JDateChooser joiningDateChooser;
	private JDateChooser expiryDateChooser;
	
	private boolean isAdmin = false;
	private int point = 100;
	private boolean status = true;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					RegisterForm frame = new RegisterForm();
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
	public RegisterForm() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(320, 180, 750, 350);
		contentPane = new JPanel();
		contentPane.setBackground(new Color(192, 192, 192));
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		
		JLabel lblNewLabel = new JLabel("X");
		lblNewLabel.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
		lblNewLabel.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				dispose();
			}
		});
		lblNewLabel.setBounds(707, 0, 43, 19);
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		contentPane.setLayout(null);
		contentPane.add(lblNewLabel);
		
		username = new JTextField();
		username.setFont(new Font("Tahoma", Font.PLAIN, 15));
		username.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		username.setColumns(10);
		username.setBounds(240, 58, 249, 20);
		contentPane.add(username);
		
		id = new JTextField();
		id.setFont(new Font("Tahoma", Font.PLAIN, 15));
		id.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		id.setColumns(10);
		id.setBounds(240, 108, 249, 20);
		contentPane.add(id);
		
		password = new JTextField();
		password.setFont(new Font("Tahoma", Font.PLAIN, 15));
		password.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		password.setColumns(10);
		password.setBounds(240, 158, 249, 20);
		contentPane.add(password);
		
		lblRegister = new JLabel(" REGISTER");
		lblRegister.setIcon(new ImageIcon(RegisterForm.class.getResource("/register.png")));
		lblRegister.setForeground(new Color(255, 255, 255));
		lblRegister.setHorizontalAlignment(SwingConstants.CENTER);
		lblRegister.setFont(new Font("Tahoma", Font.BOLD, 25));
		lblRegister.setBounds(230, 0, 259, 37);
		contentPane.add(lblRegister);
		
		lblNewLabel_1 = new JLabel("Username");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1.setBounds(240, 40, 100, 15);
		contentPane.add(lblNewLabel_1);
		
		lblNewLabel_2 = new JLabel("Library ID");
		lblNewLabel_2.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_2.setForeground(new Color(255, 255, 255));
		lblNewLabel_2.setBounds(240, 90, 100, 15);
		contentPane.add(lblNewLabel_2);
		
		lblNewLabel_3 = new JLabel("Password");
		lblNewLabel_3.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_3.setForeground(new Color(255, 255, 255));
		lblNewLabel_3.setBounds(240, 140, 100, 15);
		contentPane.add(lblNewLabel_3);
		
		lblNewLabel_4 = new JLabel("Joining Date");
		lblNewLabel_4.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_4.setForeground(new Color(255, 255, 255));
		lblNewLabel_4.setBounds(240, 190, 100, 15);
		contentPane.add(lblNewLabel_4);
		
		lblNewLabel_5 = new JLabel("Expiry Date");
		lblNewLabel_5.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_5.setForeground(new Color(255, 255, 255));
		lblNewLabel_5.setBounds(240, 240, 100, 15);
		contentPane.add(lblNewLabel_5);
		
		txtSubmit = new JTextField();
		txtSubmit.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnectToProperties.getConnection());
				) {
					String query = "insert into Account(AccountName, LibraryID, Password, IsAdmin, DJoined, DExpired, Point, Status)values(?,?,?,?,?,?,?,?)";
					PreparedStatement pst = connection.prepareStatement(query);
					pst.setString(1, username.getText());
					pst.setString(2, id.getText());
					pst.setString(3, password.getText());
					pst.setBoolean(4, isAdmin);
					
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String joiningDate = sdf.format(joiningDateChooser.getDate());
					pst.setString(5, joiningDate);
					
					String expiryDate = sdf.format(expiryDateChooser.getDate());
					pst.setString(6, expiryDate);
					
					pst.setInt(7, point);
					pst.setBoolean(8, status);
					
					pst.executeUpdate();
					JOptionPane.showMessageDialog(null, "Account created successfully!");
					
					username.setText("");
					id.setText("");
					password.setText("");
					joiningDateChooser.setCalendar(null);
					expiryDateChooser.setCalendar(null);
					
				} catch (SQLException error) {
					System.out.println(error.getMessage());
				}
			}
		});
		txtSubmit.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
		txtSubmit.setForeground(new Color(255, 255, 255));
		txtSubmit.setBackground(new Color(60, 179, 113));
		txtSubmit.setHorizontalAlignment(SwingConstants.CENTER);
		txtSubmit.setText("SUBMIT");
		txtSubmit.setBorder(new BevelBorder(BevelBorder.RAISED, null, null, null, null));
		txtSubmit.setEditable(false);
		txtSubmit.setBounds(277, 292, 70, 20);
		contentPane.add(txtSubmit);
		txtSubmit.setColumns(10);
		
		txtReset = new JTextField();
		txtReset.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
		txtReset.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				username.setText("");
				id.setText("");
				password.setText("");
				joiningDateChooser.setCalendar(null);
				expiryDateChooser.setCalendar(null);
			}
		});
		txtReset.setForeground(new Color(255, 255, 255));
		txtReset.setBackground(new Color(255, 140, 0));
		txtReset.setHorizontalAlignment(SwingConstants.CENTER);
		txtReset.setText("RESET");
		txtReset.setBorder(new BevelBorder(BevelBorder.RAISED, null, null, null, null));
		txtReset.setEditable(false);
		txtReset.setColumns(10);
		txtReset.setBounds(387, 292, 70, 20);
		contentPane.add(txtReset);
		
		lblNewLabel_7 = new JLabel("Already have an account? Sign in");
		lblNewLabel_7.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				LoginForm field = new LoginForm();
				field.setVisible(true);
				setVisible(false);
			}
		});
		lblNewLabel_7.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
		lblNewLabel_7.setForeground(new Color(0, 191, 255));
		lblNewLabel_7.setBounds(240, 323, 249, 14);
		contentPane.add(lblNewLabel_7);
		
		joiningDateChooser = new JDateChooser();
		joiningDateChooser.setBounds(240, 209, 249, 20);
		contentPane.add(joiningDateChooser);
		
		expiryDateChooser = new JDateChooser();
		expiryDateChooser.setBounds(240, 261, 249, 20);
		contentPane.add(expiryDateChooser);
		
		lblNewLabel_6 = new JLabel("");
		lblNewLabel_6.setBackground(new Color(112, 128, 144));
		lblNewLabel_6.setOpaque(true);
		lblNewLabel_6.setForeground(new Color(255, 255, 255));
		lblNewLabel_6.setBounds(187, 33, 353, 312);
		contentPane.add(lblNewLabel_6);

		setUndecorated(true);
	}
}
