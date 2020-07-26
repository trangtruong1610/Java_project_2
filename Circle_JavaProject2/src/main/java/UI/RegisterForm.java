package UI;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import common.ConnecToProperties;
import entity.Account;

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
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.awt.Cursor;
import com.toedter.calendar.JDateChooser;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JPasswordField;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;

public class RegisterForm extends JFrame {

	private JPanel contentPane;
	private JTextField username;
	private JTextField id;
	private JLabel lblRegister;
	private JLabel lblNewLabel_1;
	private JLabel lblNewLabel_2;
	private JLabel lblNewLabel_3;
	private JLabel lblNewLabel_4;
	private JLabel Panel;
	private JLabel lblNewLabel_7;
	private JLabel user_validation ;
	private JDateChooser joiningDateChooser;
	private String joiningDate, txtName, txtId, txtPass;
	
//	private JDateChooser expiryDateChooser;
	private boolean isAdmin = false;
	private int point = 100;
	private boolean status = true;
	private JButton btnNewButton;
	private JButton btnReset;
	private JPasswordField password;
	private JLabel id_validation;
	private JLabel pass_validation;
	private JLabel date_validation;

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
		setBounds(320, 180, 750, 450);
		contentPane = new JPanel();
		contentPane.setBackground(new Color(192, 192, 192));
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		username = new JTextField();
		username.addFocusListener(new FocusAdapter() {
			
			@Override
			public void focusLost(FocusEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) {
					String queryAcc = "SELECT * From Account where AccountName=?";
					PreparedStatement pstAcc = connection.prepareStatement(queryAcc);
					pstAcc.setString(1, username.getText());
					ResultSet rsAcc = pstAcc.executeQuery();
					
					if(rsAcc.next()) {
						user_validation.setText("Username already exists");
						user_validation.setForeground(Color.cyan);
						} else {
							String USER_PATTERN = "Student\\d{3,10}";
							Pattern patternUser = Pattern.compile(USER_PATTERN);
							Matcher matcherUser = patternUser.matcher(username.getText()); 
							if(matcherUser.matches()) {
								user_validation.setText("");
								txtName = username.getText();
							}else {
								user_validation.setForeground(Color.red);
								user_validation.setText("Account Name must start with Student*****");
							}
						}
					} catch (SQLException err) {
					System.out.println(err.getMessage());
				}
			}
		});
		username.setFont(new Font("Tahoma", Font.PLAIN, 15));
		username.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		username.setColumns(10);
		username.setBounds(240, 70, 250, 20);
		contentPane.add(username);
		
		id = new JTextField();
		id.setForeground(new Color(0, 0, 0));
		id.addFocusListener(new FocusAdapter() {
			@Override
			public void focusLost(FocusEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) {
					String queryDB = "SELECT * From Account where LibraryID=?";
					PreparedStatement pstDB = connection.prepareStatement(queryDB);
					pstDB.setString(1, id.getText());
					ResultSet rs = pstDB.executeQuery();
					
					if(rs.next()) {
						id_validation.setText("Library ID already exists");
						id_validation.setForeground(Color.cyan);
						} else {
							String ID_PATTERN = "\\d{6}[-][A-Z]\\d{4}";
							Pattern pattern =Pattern.compile(ID_PATTERN);
							Matcher matcher = pattern.matcher(id.getText()); 
							if(matcher.matches()) {
								id_validation.setText("");
								txtId = id.getText();
							}else {
								id_validation.setForeground(Color.red);
								id_validation.setText("Library ID must start with 000000-A0000");
							}
						}
					} catch (SQLException err) {
					System.out.println(err.getMessage());
				}
			}
		});
		id.setFont(new Font("Tahoma", Font.PLAIN, 15));
		id.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		id.setColumns(10);
		id.setBounds(240, 140, 250, 20);
		contentPane.add(id);
		
		lblRegister = new JLabel(" REGISTER");
		lblRegister.setIcon(new ImageIcon(RegisterForm.class.getResource("/register.png")));
		lblRegister.setForeground(new Color(255, 255, 255));
		lblRegister.setHorizontalAlignment(SwingConstants.CENTER);
		lblRegister.setFont(new Font("Tahoma", Font.BOLD, 25));
		lblRegister.setBounds(230, 0, 259, 37);
		contentPane.add(lblRegister);
		
		lblNewLabel_1 = new JLabel("Account Name");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1.setBounds(240, 50, 100, 15);
		contentPane.add(lblNewLabel_1);
		
		user_validation = new JLabel("");
		user_validation.setFont(new Font("Tahoma", Font.BOLD, 10));
		user_validation.setForeground(new Color(255, 0, 0));
		user_validation.setBounds(240, 95, 250, 14);
		contentPane.add(user_validation);
		
		lblNewLabel_2 = new JLabel("Library ID");
		lblNewLabel_2.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_2.setForeground(new Color(255, 255, 255));
		lblNewLabel_2.setBounds(240, 120, 100, 15);
		contentPane.add(lblNewLabel_2);
		
		id_validation = new JLabel("");
		id_validation.setFont(new Font("Tahoma", Font.BOLD, 10));
		id_validation.setForeground(new Color(255, 0, 0));
		id_validation.setBounds(240, 165, 250, 14);
		contentPane.add(id_validation);
		
		lblNewLabel_3 = new JLabel("Password");
		lblNewLabel_3.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_3.setForeground(new Color(255, 255, 255));
		lblNewLabel_3.setBounds(240, 190, 100, 15);
		contentPane.add(lblNewLabel_3);
		
		pass_validation = new JLabel("");
		pass_validation.setFont(new Font("Tahoma", Font.BOLD, 10));
		pass_validation.setForeground(new Color(255, 0, 0));
		pass_validation.setBounds(240, 235, 250, 14);
		contentPane.add(pass_validation);
		
		password = new JPasswordField();
		password.addFocusListener(new FocusAdapter() {
			@Override
			public void focusLost(FocusEvent e) {
				if(password.getText().length() < 8 || password.getText().length() > 20) {
					pass_validation.setText("Password must be 8 to 20 character");
				}else {
					pass_validation.setText("");
					txtPass = password.getText();
				}
			}
		});
		password.setBounds(240, 210, 250, 20);
		contentPane.add(password);
		
		lblNewLabel_4 = new JLabel("Joining Date");
		lblNewLabel_4.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_4.setForeground(new Color(255, 255, 255));
		lblNewLabel_4.setBounds(240, 260, 100, 15);
		contentPane.add(lblNewLabel_4);
		
		date_validation = new JLabel("");
		date_validation.setForeground(Color.RED);
		date_validation.setFont(new Font("Tahoma", Font.BOLD, 10));
		date_validation.setBounds(240, 305, 250, 14);
		contentPane.add(date_validation);
		
		btnNewButton = new JButton("SUBMIT");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) { 
					if(txtName != null && txtId != null && txtPass != null) {
						String query = "insert into Account(AccountName, LibraryID, Password, IsAdmin, DJoined, Points, Status)values(?,?,?,?,?,?,?)";
						PreparedStatement pst = connection.prepareStatement(query);
						pst.setString(1, username.getText());
						pst.setString(2, id.getText());
						pst.setString(3, password.getText());
						pst.setBoolean(4, isAdmin);
						
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						joiningDate = sdf.format(joiningDateChooser.getDate());
						pst.setString(5, joiningDate);
						
//						String expiryDate = sdf.format(expiryDateChooser.getDate());
//						pst.setString(6, expiryDate);
//						System.out.println(expiryDate);
						
						pst.setInt(6, point);
						pst.setBoolean(7, status);
						
						pst.executeUpdate();
						JOptionPane.showMessageDialog(null, "Account created successfully!");
						
						LoginForm field = new LoginForm();
						field.setVisible(true);
						setVisible(false);
						
//						username.setText("");
//						id.setText("");
//						password.setText("");
//						joiningDateChooser.setCalendar(null);
//						expiryDateChooser.setCalendar(null);
					}else {
						JOptionPane.showMessageDialog(null, "Please fill in the required fields");
					}
				} catch (SQLException error) {
					JOptionPane.showMessageDialog(null, "Error!");
//					System.out.println(error.getMessage());
				}
			}
		});
		btnNewButton.setFont(new Font("Tahoma", Font.BOLD, 13));
		btnNewButton.setForeground(new Color(255, 255, 255));
		btnNewButton.setBackground(new Color(60, 179, 113));
		btnNewButton.setBounds(240, 334, 110, 23);
		contentPane.add(btnNewButton);
		
		btnReset = new JButton("RESET");
		btnReset.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				username.setText("");
				user_validation.setText("");
				id.setText("");
				password.setText("");
				joiningDateChooser.setCalendar(null);
//				expiryDateChooser.setCalendar(null);
			}
		});
		btnReset.setBackground(new Color(255, 140, 0));
		btnReset.setForeground(new Color(255, 255, 255));
		btnReset.setFont(new Font("Tahoma", Font.BOLD, 13));
		btnReset.setBounds(388, 334, 100, 23);
		contentPane.add(btnReset);
		
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
		lblNewLabel_7.setBounds(240, 368, 249, 14);
		contentPane.add(lblNewLabel_7);
		
		joiningDateChooser = new JDateChooser();
		joiningDateChooser.setDate(java.sql.Date.valueOf(java.time.LocalDate.now())); 
		joiningDateChooser.addFocusListener(new FocusAdapter() {
			@Override
			public void focusLost(FocusEvent e) {
			}
		});
		joiningDateChooser.setBounds(240, 280, 250, 20);
		contentPane.add(joiningDateChooser);
		
//		expiryDateChooser = new JDateChooser();
//		expiryDateChooser.setBounds(240, 261, 249, 20);
//		contentPane.add(expiryDateChooser);
		
		Panel = new JLabel("");
		Panel.setBackground(new Color(112, 128, 144));
		Panel.setOpaque(true);
		Panel.setForeground(new Color(255, 255, 255));
		Panel.setBounds(187, 33, 353, 360);
		contentPane.add(Panel);
	}
}
