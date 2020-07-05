package UI;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.border.MatteBorder;
import java.awt.Color;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import javax.swing.SwingConstants;
import javax.swing.JTextField;
import com.toedter.calendar.JDateChooser;

import common.ConnectToProperties;
import entity.Account;

import javax.swing.JComboBox;
import javax.swing.JButton;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.DefaultComboBoxModel;
import javax.swing.ImageIcon;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

public class AccountManagement extends JFrame {

	private JPanel contentPane;
	private JFrame frame;
	private JTextField username;
	private JTextField id;
	private JTextField password;
	private JTextField point;
	private JTable tableAccount;
	private boolean isAdmin = false;
	private JTextField no;
	private JTextField searchdata;
	
	public ArrayList<Account> accountsList(){
		ArrayList<Account> accountsList = new ArrayList<>();
		try (
				var connection = DriverManager.getConnection(ConnectToProperties.getConnection());
		) {
			String query = "SELECT * FROM Account";
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery(query);
			Account account;
			
			while(rs.next()) {
				account = new Account(rs.getInt("accountNo"), rs.getString("accountName"), rs.getString("libraryID"), rs.getString("password"), rs.getBoolean("isAdmin"), rs.getString("dJoined"),rs.getString("dExpired"),rs.getInt("point"),rs.getBoolean("status"));
				accountsList.add(account);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return accountsList;
	}
	
	public void show_account() {
		ArrayList<Account> list = accountsList();
		DefaultTableModel model = (DefaultTableModel)tableAccount.getModel();
		Object[] row = new Object[8];
		for(int i=0; i<list.size(); i++) {
			row[0] = list.get(i).getAccountNo();
			row[1] = list.get(i).getAccountName();
			row[2] = list.get(i).getLibraryID();
			row[3] = list.get(i).getPassword();
			row[4] = list.get(i).getDJoined();
			row[5] = list.get(i).getDExpired();
			row[6] = list.get(i).getPoint();
			String status = "Enable";
			if (list.get(i).getStatus().equals(false)) {
				status = "Disable";
			}
			row[7] = status;
			model.addRow(row);
		}
	}

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					AccountManagement frame = new AccountManagement();
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
	public AccountManagement() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(320, 180, 900, 555);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(220, 220, 220));
		panel.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel.setBounds(0, 0, 900, 555);
		contentPane.add(panel);
		panel.setLayout(null);
		
		JPanel panel_1 = new JPanel();
		panel_1.setLayout(null);
		panel_1.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_1.setBackground(new Color(220, 220, 220));
		panel_1.setBounds(10, 10, 880, 31);
		panel.add(panel_1);
		
		JLabel lblNewLabel = new JLabel("LIBRARY SYSTEM");
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 20));
		lblNewLabel.setBounds(0, 0, 880, 31);
		panel_1.add(lblNewLabel);
		
		JPanel panel_1_1 = new JPanel();
		panel_1_1.setLayout(null);
		panel_1_1.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_1_1.setBackground(new Color(220, 220, 220));
		panel_1_1.setBounds(10, 35, 250, 461);
		panel.add(panel_1_1);
		
		JLabel lblNewLabel_1 = new JLabel("Username");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1.setBounds(10, 100, 100, 15);
		panel_1_1.add(lblNewLabel_1);
		
		JLabel lblNewLabel_1_1 = new JLabel("Library ID");
		lblNewLabel_1_1.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_1.setBounds(10, 150, 100, 15);
		panel_1_1.add(lblNewLabel_1_1);
		
		JLabel lblNewLabel_1_2 = new JLabel("Password");
		lblNewLabel_1_2.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_2.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_2.setBounds(10, 200, 100, 15);
		panel_1_1.add(lblNewLabel_1_2);
		
		JLabel lblNewLabel_1_3 = new JLabel("Joining Date");
		lblNewLabel_1_3.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_3.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_3.setBounds(10, 250, 100, 15);
		panel_1_1.add(lblNewLabel_1_3);
		
		JLabel lblNewLabel_1_4 = new JLabel("Expiry Date");
		lblNewLabel_1_4.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_4.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_4.setBounds(10, 300, 100, 15);
		panel_1_1.add(lblNewLabel_1_4);
		
		JLabel lblNewLabel_1_5 = new JLabel("Point");
		lblNewLabel_1_5.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_5.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_5.setBounds(10, 350, 100, 15);
		panel_1_1.add(lblNewLabel_1_5);
		
		JLabel lblNewLabel_1_6 = new JLabel("Status");
		lblNewLabel_1_6.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_6.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_6.setBounds(10, 400, 100, 15);
		panel_1_1.add(lblNewLabel_1_6);
		
		username = new JTextField();
		username.setBounds(10, 120, 215, 20);
		panel_1_1.add(username);
		username.setColumns(10);
		
		id = new JTextField();
		id.setColumns(10);
		id.setBounds(10, 170, 215, 20);
		panel_1_1.add(id);
		
		password = new JTextField();
		password.setColumns(10);
		password.setBounds(10, 220, 215, 20);
		panel_1_1.add(password);
		
		point = new JTextField();
		point.setColumns(10);
		point.setBounds(10, 370, 215, 20);
		panel_1_1.add(point);
		
		JDateChooser joiningDateChooser = new JDateChooser();
		joiningDateChooser.setBounds(10, 270, 215, 20);
		panel_1_1.add(joiningDateChooser);
		
		JDateChooser expiryDateChooser = new JDateChooser();
		expiryDateChooser.setBounds(10, 320, 215, 20);
		panel_1_1.add(expiryDateChooser);
		
		JComboBox status = new JComboBox();
		status.setModel(new DefaultComboBoxModel(new String[] {"Enable", "Disable"}));
		status.setBounds(10, 420, 215, 22);
		panel_1_1.add(status);
		
		JLabel lblSearch = new JLabel("");
		lblSearch.setForeground(new Color(255, 255, 255));
		lblSearch.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblSearch.setIcon(new ImageIcon(LoginForm.class.getResource("/search.png")));
		lblSearch.setBounds(215, 10, 35, 30);
		panel_1_1.add(lblSearch);
		
		no = new JTextField();
		no.setColumns(10);
		no.setBounds(10, 70, 215, 20);
		panel_1_1.add(no);
		
		searchdata = new JTextField();
		searchdata.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnectToProperties.getConnection());
				) {
					String sql = "Select * from Account where AccountNo = ?";
					PreparedStatement pst = connection.prepareStatement(sql);
					pst.setString(1, searchdata.getText());
					ResultSet rs = pst.executeQuery();
					if(rs.next()) {
						String setNo = String.valueOf(rs.getInt("AccountNo"));
						no.setText(setNo);
						
						String setUsername = rs.getString("AccountName");
						username.setText(setUsername);
						
						String setId = rs.getString("LibraryID");
						id.setText(setId);
						
						String setPassword = rs.getString("Password");
						password.setText(setPassword);
						
						joiningDateChooser.setDate(rs.getDate("DJoined"));
						expiryDateChooser.setDate(rs.getDate("DExpired"));
						
						String setPoint = rs.getString("Point");
						point.setText(setPoint);
						
						boolean _status = rs.getBoolean("Status");
						status.setSelectedIndex(1);
						if(_status) {
							status.setSelectedIndex(0);
						}
					}
				} catch (SQLException error) {
					System.out.println(error.getMessage());
				}
			}
		});
		searchdata.setColumns(10);
		searchdata.setBounds(10, 15, 195, 20);
		panel_1_1.add(searchdata);
		
		JLabel lblNewLabel_1_7 = new JLabel("No");
		lblNewLabel_1_7.setForeground(Color.WHITE);
		lblNewLabel_1_7.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_7.setBounds(10, 50, 100, 15);
		panel_1_1.add(lblNewLabel_1_7);
		
		JPanel panel_1_1_1 = new JPanel();
		panel_1_1_1.setLayout(null);
		panel_1_1_1.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_1_1_1.setBackground(new Color(220, 220, 220));
		panel_1_1_1.setBounds(259, 39, 631, 457);
		panel.add(panel_1_1_1);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(10, 11, 607, 435);
		panel_1_1_1.add(scrollPane);
		
		tableAccount = new JTable();
		tableAccount.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				int index = tableAccount.getSelectedRow();
				TableModel model = tableAccount.getModel();
				no.setText(model.getValueAt(index, 0).toString());
				username.setText(model.getValueAt(index, 1).toString());
				id.setText(model.getValueAt(index, 2).toString());
				password.setText(model.getValueAt(index, 3).toString());
				
				try {
					int srow = tableAccount.getSelectedRow();
					Date joiningDate = new SimpleDateFormat("yyyy-MM-dd").parse((String)model.getValueAt(srow, 4));
					joiningDateChooser.setDate(joiningDate);
					
					Date expiryDate = (Date)new SimpleDateFormat("yyyy-MM-dd").parse((String)model.getValueAt(srow, 5));
					expiryDateChooser.setDate(expiryDate);
				}catch(Exception err) {
					JOptionPane.showMessageDialog(null, err);
				}
				
				point.setText(model.getValueAt(index, 6).toString());
				
				String status_ = model.getValueAt(index, 7).toString();
				switch(status_) {
				case "Enable":
					status.setSelectedIndex(0);
					break;
				case "Disable":
					status.setSelectedIndex(1);
					break;
				}
				
				username.setText(model.getValueAt(index, 1).toString());
				username.setText(model.getValueAt(index, 1).toString());
			}
		});
		tableAccount.setModel(new DefaultTableModel(
			new Object[][] {
			},
			new String[] {
				"No", "Username", "Library ID", "Password", "Joining Date", "Expiry Date", "Point", "Status"
			}
		));
		scrollPane.setViewportView(tableAccount);
		
		JPanel panel_1_2 = new JPanel();
		panel_1_2.setLayout(null);
		panel_1_2.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_1_2.setBackground(new Color(220, 220, 220));
		panel_1_2.setBounds(10, 494, 880, 50);
		panel.add(panel_1_2);
		
		JButton btnCreate = new JButton("CREATE");
		btnCreate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
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
					
					pst.setString(7, point.getText());
					
					String _status = status.getSelectedItem().toString();
					boolean status_ = false;
					if(_status.equals("Enable")) {
						status_ = true;
					}
					pst.setBoolean(8, status_);
					
					pst.executeUpdate();
					
					DefaultTableModel model = (DefaultTableModel)tableAccount.getModel();
					model.setRowCount(0);
					show_account();
					JOptionPane.showMessageDialog(null, "Account created successfully!");
					
					username.setText("");
					password.setText("");
					id.setText("");
					joiningDateChooser.setCalendar(null);
					expiryDateChooser.setCalendar(null);
					point.setText("");
					status.setSelectedIndex(0);
					
				} catch (SQLException err) {
					System.out.println(err.getMessage());
				}
				
			}
		});
		btnCreate.setForeground(new Color(255, 255, 255));
		
		btnCreate.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnCreate.setBounds(40, 11, 100, 23);
		panel_1_2.add(btnCreate);
		
		JButton btnUpdate = new JButton("UPDATE");
		btnUpdate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnectToProperties.getConnection());
				) {
					String value = no.getText();
					String query = "UPDATE Account SET AccountName=?, LibraryID=?, Password=?, DJoined=?, DExpired=?, Point=?, Status=? where AccountNo =" + value;
					PreparedStatement pst = connection.prepareStatement(query);
					
					pst.setString(1, username.getText());
					pst.setString(2, id.getText());
					pst.setString(3, password.getText());
					
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String joiningDate = sdf.format(joiningDateChooser.getDate());
					pst.setString(4, joiningDate);
					
					String expiryDate = sdf.format(expiryDateChooser.getDate());
					pst.setString(5, expiryDate);
					
					pst.setString(6, point.getText());
					
					String _status = status.getSelectedItem().toString();
					boolean status_ = false;
					if(_status.equals("Enable")) {
						status_ = true;
					}
					pst.setBoolean(7, status_);

					pst.executeLargeUpdate();
					DefaultTableModel model = (DefaultTableModel)tableAccount.getModel();
					model.setRowCount(0);
					show_account();
					JOptionPane.showInternalMessageDialog(null, "Updated Successfully!");
				} catch (SQLException error) {
					System.out.println(error.getMessage());
				}
			}
		});
		btnUpdate.setForeground(new Color(255, 255, 255));
		btnUpdate.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnUpdate.setBounds(220, 11, 100, 23);
		panel_1_2.add(btnUpdate);
		
		JButton btnClear = new JButton("CLEAR");
		btnClear.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				username.setText("");
				password.setText("");
				id.setText("");
				joiningDateChooser.setCalendar(null);
				expiryDateChooser.setCalendar(null);
				point.setText("");
				status.setSelectedIndex(0);
			}
		});
		btnClear.setForeground(new Color(255, 255, 255));
		btnClear.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnClear.setBounds(580, 11, 100, 23);
		panel_1_2.add(btnClear);
		
		JButton btnClose = new JButton("CLOSE");
		btnClose.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				dispose();
			}
		});
		btnClose.setForeground(new Color(255, 255, 255));
		btnClose.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnClose.setBounds(740, 11, 100, 23);
		panel_1_2.add(btnClose);
		
		JButton btnDelete = new JButton("DELETE");
		btnDelete.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int opt = JOptionPane.showConfirmDialog(null,"Are You sure to Delete", "Delete", JOptionPane.YES_NO_OPTION);
				
				if(opt==0) {
					try (
							var connection = DriverManager.getConnection(ConnectToProperties.getConnection());
					) {
						int row = tableAccount.getSelectedRow();
						String value = (tableAccount.getModel().getValueAt(row, 0).toString());
						String query = "DELETE FROM Account where AccountNo=" + value;
						PreparedStatement pst = connection.prepareStatement(query);
						pst.executeUpdate();
						
						DefaultTableModel model = (DefaultTableModel)tableAccount.getModel();
						model.setRowCount(0);
						
						show_account();
						JOptionPane.showMessageDialog(null, "Deleted Successfully!");
						
						username.setText("");
						password.setText("");
						id.setText("");
						joiningDateChooser.setCalendar(null);
						expiryDateChooser.setCalendar(null);
						point.setText("");
						status.setSelectedIndex(0);
						
					} catch (SQLException error) {
						System.out.println(error.getMessage());
					}
				}
			}
		});
		btnDelete.setForeground(Color.WHITE);
		btnDelete.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnDelete.setBounds(400, 11, 100, 23);
		panel_1_2.add(btnDelete);
		
		show_account();
		setUndecorated(true);
	}
}
