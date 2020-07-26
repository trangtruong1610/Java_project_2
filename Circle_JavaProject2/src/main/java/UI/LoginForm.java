package UI;

import entity.Account;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.text.JTextComponent;

import common.ConnecToProperties;

import java.awt.Color;
import javax.swing.JTextField;
import java.awt.Font;
import java.awt.Toolkit;

import javax.swing.border.BevelBorder;
import javax.swing.SwingConstants;
import javax.swing.JLabel;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JPasswordField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class LoginForm extends JFrame {

	private JPanel contentPane;
	public static JTextField username;
	public static JPasswordField passwordField;
	private JLabel lblmessage;
	private static LoginForm frame;
	private JLabel create;
	private JButton btnNewButton;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					frame = new LoginForm();
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
	public LoginForm() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(320, 180, 750, 350);
		contentPane = new JPanel();
		contentPane.setBackground(new Color(105, 105, 105));
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		username = new JTextField();
		username.setFont(new Font("Tahoma", Font.PLAIN, 15));
		username.setBounds(300, 127, 200, 20);
		contentPane.add(username);
		username.setColumns(10);
		
		JLabel id = new JLabel("");
		id.setHorizontalAlignment(SwingConstants.CENTER);
		id.setIcon(new ImageIcon(LoginForm.class.getResource("/lib-id.png")));
		id.setBounds(230, 107, 60, 50);
		contentPane.add(id);
		
		JLabel password = new JLabel("");
		password.setHorizontalAlignment(SwingConstants.CENTER);
		password.setIcon(new ImageIcon(LoginForm.class.getResource("/uPass.png")));
		password.setBounds(230, 176, 60, 15);
		contentPane.add(password);
		
		JLabel lblLogin = new JLabel(" LOGIN");
		lblLogin.setIcon(new ImageIcon(LoginForm.class.getResource("/Book-icon.png")));
		lblLogin.setForeground(new Color(255, 255, 255));
		lblLogin.setHorizontalAlignment(SwingConstants.CENTER);
		lblLogin.setFont(new Font("Tahoma", Font.BOLD, 25));
		lblLogin.setBounds(300, 70, 200, 39);
		contentPane.add(lblLogin);
		
		passwordField = new JPasswordField();
		passwordField.setBounds(300, 176, 200, 20);
		contentPane.add(passwordField);
		
		lblmessage = new JLabel("Invalid Username OR Password");
		lblmessage.setForeground(new Color(255, 99, 71));
		lblmessage.setBounds(300, 207, 200, 14);
		contentPane.add(lblmessage);
		
		create = new JLabel("Sign up to create your account");
		create.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				RegisterForm field = new RegisterForm();
				field.setVisible(true);
				setVisible(false);
			}
		});
		create.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
		create.setForeground(new Color(0, 191, 255));
		create.setBounds(299, 256, 201, 14);
		contentPane.add(create);
		
		JButton btnSignIn = new JButton("SIGN IN");
		btnSignIn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) { 
					String query = "Select * from Account where AccountName=? and Password=?";
					PreparedStatement pst = connection.prepareStatement(query);
					pst.setString(1, username.getText());
					pst.setString(2,passwordField.getText());
					ResultSet rs = pst.executeQuery();
					
					if(rs.next()){
						if(rs.getBoolean("IsAdmin")){
							AccountManagement field = new AccountManagement();
							field.setVisible(true);
							setVisible(false);
						}else{
							MemberPage field = new MemberPage();
							field.setVisible(true);
							setVisible(false);
						}
					}else{
						lblmessage.setVisible(true);
						username.setText("");
						passwordField.setText("");
						username.requestFocus();
					}
					connection.close();
				} catch (SQLException error) {
					System.out.println(error.getMessage());
				}
			}
		});
		btnSignIn.setBackground(new Color(65, 105, 225));
		btnSignIn.setForeground(new Color(255, 255, 255));
		btnSignIn.setBounds(300, 228, 89, 23);
		contentPane.add(btnSignIn);
		
		btnNewButton = new JButton("RESET");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				username.setText("");
		        passwordField.setText("");
		        lblmessage.setVisible(false);
		        username.requestFocus();
			}
		});
		btnNewButton.setBackground(new Color(255, 140, 0));
		btnNewButton.setForeground(new Color(255, 255, 255));
		btnNewButton.setBounds(413, 228, 89, 23);
		contentPane.add(btnNewButton);
		lblmessage.setVisible(false);
	}
}
