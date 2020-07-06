package view;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.table.DefaultTableModel;

import DAO.DAOBook;
import common.ConnecToProperties;
import entity.Book;

import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.ImageIcon;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import java.awt.Image;

import javax.swing.JTextField;
import javax.swing.LayoutStyle.ComponentPlacement;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.awt.event.ActionEvent;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import com.toedter.calendar.JDateChooser;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class InsertBook extends JFrame {

	private JPanel contentPane;
	public JLabel lblBookno;
	public JLabel lblTitle;
	public JLabel lblPublisher;
	public JLabel lblAuthor;
	public JLabel lblIsbn;
	public JLabel lblPages;
	public JTextField txtBookno;
	public JTextField txtTitle;
	public JTextField txtPublisher;
	public JTextField txtAuthor;
	public JTextField txtISBN;
	public JTextField txtPages;
	public JButton btnInsert;
	public JButton btnUpdate;
	public JScrollPane scrollPane;
	public JTable table;
	public JButton btnUpload;
	public JLabel lblImage;
	String filename = null;
	byte[] person_image = null;
	public JDateChooser dateChooser;
	public JLabel lblYpublished;
	public JLabel lblshelfNo;
	public JTextField txtShelfNo;
	public JButton btnLoad;
	public JButton btnDelete;
	public JButton btnNew;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					InsertBook frame = new InsertBook();
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
	public InsertBook() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 905, 817);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);

		lblBookno = new JLabel("BookNo");
		lblBookno.setBounds(32, 42, 72, 31);
		lblBookno.setFont(new Font("Times New Roman", Font.PLAIN, 16));

		lblTitle = new JLabel("Title");
		lblTitle.setBounds(34, 104, 26, 20);
		lblTitle.setFont(new Font("Times New Roman", Font.PLAIN, 16));

		lblPublisher = new JLabel("Publisher");
		lblPublisher.setBounds(33, 164, 84, 20);
		lblPublisher.setFont(new Font("Times New Roman", Font.PLAIN, 16));

		lblAuthor = new JLabel("Author");
		lblAuthor.setBounds(33, 213, 42, 20);
		lblAuthor.setFont(new Font("Times New Roman", Font.PLAIN, 16));

		lblIsbn = new JLabel("ISBN");
		lblIsbn.setBounds(33, 264, 36, 20);
		lblIsbn.setFont(new Font("Times New Roman", Font.PLAIN, 16));

		lblPages = new JLabel("Pages");
		lblPages.setBounds(33, 366, 36, 20);
		lblPages.setFont(new Font("Times New Roman", Font.PLAIN, 16));

		txtBookno = new JTextField();
		txtBookno.setEnabled(false);
		txtBookno.setBounds(119, 45, 315, 29);
		txtBookno.setColumns(10);

		txtTitle = new JTextField();
		txtTitle.setBounds(118, 101, 317, 28);
		txtTitle.setColumns(10);

		txtPublisher = new JTextField();
		txtPublisher.setBounds(118, 156, 317, 28);
		txtPublisher.setColumns(10);

		txtAuthor = new JTextField();
		txtAuthor.setBounds(118, 210, 317, 28);
		txtAuthor.setColumns(10);

		txtISBN = new JTextField();
		txtISBN.setBounds(118, 260, 317, 30);
		txtISBN.setColumns(10);

		txtPages = new JTextField();
		txtPages.setBounds(118, 363, 317, 29);
		txtPages.setColumns(10);

		btnInsert = new JButton("Insert Book");
		btnInsert.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				btnInsertActionPerformed(e);
			}
		});
		btnInsert.setBounds(554, 388, 116, 23);

		btnUpdate = new JButton("Update Book");
		btnUpdate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				btnUpdateActionPerformed(e);
			}
		});
		btnUpdate.setBounds(554, 327, 116, 23);

		scrollPane = new JScrollPane();
		scrollPane.setBounds(33, 536, 820, 227);

		btnUpload = new JButton("Upload Image");
		btnUpload.setBounds(718, 327, 116, 23);
		btnUpload.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				btnUploadActionPerformed(e);
			}
		});

		lblImage = new JLabel("Image");
		lblImage.setBounds(565, 74, 257, 149);
		lblImage.setIcon(new ImageIcon(new ImageIcon(getClass().getResource("/images/no-image.png")).getImage()
				.getScaledInstance(lblImage.getWidth(), lblImage.getHeight(), Image.SCALE_SMOOTH)));

		table = new JTable();
		table.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				tableMouseClicked(e);
			}
		});
		scrollPane.setViewportView(table);
		contentPane.setLayout(null);
		contentPane.add(lblImage);
		contentPane.add(scrollPane);
		contentPane.add(lblPublisher);
		contentPane.add(lblBookno);
		contentPane.add(lblTitle);
		contentPane.add(lblAuthor);
		contentPane.add(lblIsbn);
		contentPane.add(lblPages);
		contentPane.add(txtISBN);
		contentPane.add(txtTitle);
		contentPane.add(txtAuthor);
		contentPane.add(txtPublisher);
		contentPane.add(txtBookno);
		contentPane.add(txtPages);
		contentPane.add(btnUpdate);
		contentPane.add(btnUpload);
		contentPane.add(btnInsert);

		dateChooser = new JDateChooser();
		dateChooser.setBounds(118, 414, 317, 32);
		contentPane.add(dateChooser);

		lblYpublished = new JLabel("YPublished");
		lblYpublished.setFont(new Font("Times New Roman", Font.PLAIN, 16));
		lblYpublished.setBounds(32, 414, 74, 31);
		contentPane.add(lblYpublished);

		lblshelfNo = new JLabel("ShelfNo");
		lblshelfNo.setFont(new Font("Times New Roman", Font.PLAIN, 16));
		lblshelfNo.setBounds(33, 315, 71, 20);
		contentPane.add(lblshelfNo);

		txtShelfNo = new JTextField();
		txtShelfNo.setBounds(118, 311, 317, 31);
		contentPane.add(txtShelfNo);
		txtShelfNo.setColumns(10);

		btnLoad = new JButton("Load Book");
		btnLoad.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				btnLoadActionPerformed(e);
			}
		});
		btnLoad.setBounds(718, 387, 116, 23);
		contentPane.add(btnLoad);
		
		btnDelete = new JButton("Delete Book");
		btnDelete.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				btnDeleteActionPerformed(e);
			}
		});
		btnDelete.setBounds(554, 449, 116, 23);
		contentPane.add(btnDelete);
		
		btnNew = new JButton("New Book");
		btnNew.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				btnNewActionPerformed(e);
			}
		});
		btnNew.setBounds(718, 449, 116, 23);
		contentPane.add(btnNew);
	}

	protected void btnUploadActionPerformed(ActionEvent e) {
		JFileChooser chooser = new JFileChooser();
		chooser.setFileFilter(
				new FileNameExtensionFilter("image (jpg, png)", "jpg","png")	
			);
		chooser.setAcceptAllFileFilterUsed(false);
		chooser.showOpenDialog(null);
		File f = chooser.getSelectedFile();
				if (f == null)
			return;
		filename = f.getAbsolutePath();
		ImageIcon imageIcon = new ImageIcon(new ImageIcon(filename).getImage().getScaledInstance(lblImage.getWidth(),
				lblImage.getHeight(), Image.SCALE_SMOOTH));
		lblImage.setIcon(imageIcon);
		try {
			File image = new File(filename);
			
			FileInputStream fis = new FileInputStream(image);
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			byte[] buf = new byte[1024];
			for (int readNum; (readNum = fis.read(buf)) != -1;) {
				bos.write(buf, 0, readNum);
			}
			person_image = bos.toByteArray();
		} catch (Exception e2) {
			e2.printStackTrace();
		}
	}

	protected void btnInsertActionPerformed(ActionEvent e) {
		Book book = new Book();
		DAOBook dao = new DAOBook();
		book.setTitle(txtTitle.getText());
		book.setPublisher(txtPublisher.getText());
		book.setAuthor(txtAuthor.getText());
		book.setIsbn(txtISBN.getText());
		book.setShelfNo(Integer.parseInt(txtShelfNo.getText()));
		book.setPages(Integer.parseInt(txtPages.getText()));
		book.setYpublished(dateChooser.getDate());
		book.setPicture(person_image);
		dao.insertBook(book);
		loadData();
	}

	protected void btnLoadActionPerformed(ActionEvent e) {
		loadData();
	}

	private void loadData() {
		DAOBook daoBook = new DAOBook();
		DefaultTableModel model = new DefaultTableModel();
		model.addColumn("Book Id");
		model.addColumn("Title");
		model.addColumn("Publisher");
		model.addColumn("Author");
		model.addColumn("ISBN");
		model.addColumn("Pages");
		model.addColumn("ShelfNo");
		model.addColumn("YPublished");
		model.addColumn("Images");
		for (Book boo : daoBook.getAllBook()) {
			model.addRow(new Object[] { boo.getBookNo(), boo.getTitle(), boo.getPublisher(), boo.getAuthor(),
					boo.getIsbn(), boo.getPages(), boo.getShelfNo(), boo.getYpublished(), boo.getPicture() });

		}
		table.setModel(model);
	}

	protected void tableMouseClicked(MouseEvent e) {
		int selectRow = table.getSelectedRow();
		txtBookno.setText(table.getValueAt(selectRow, 0).toString());
		txtTitle.setText(table.getValueAt(selectRow, 1).toString());
		txtPublisher.setText(table.getValueAt(selectRow, 2).toString());
		txtAuthor.setText(table.getValueAt(selectRow, 3).toString());
		txtISBN.setText(table.getValueAt(selectRow, 4).toString());
		txtPages.setText(table.getValueAt(selectRow, 5).toString());
		txtShelfNo.setText(table.getValueAt(selectRow, 6).toString());
		dateChooser.setDate((Date) table.getValueAt(selectRow, 7));
		byte[] img = (byte[]) (table.getValueAt(selectRow, 8));
		if (img == null) {
			lblImage.setIcon(new ImageIcon(new ImageIcon(getClass().getResource("/images/no-image.png")).getImage()
					.getScaledInstance(lblImage.getWidth(), lblImage.getHeight(), Image.SCALE_SMOOTH)));
		} else {
			ImageIcon imageIcon = new ImageIcon(new ImageIcon(img).getImage().getScaledInstance(lblImage.getWidth(),
					lblImage.getHeight(), Image.SCALE_SMOOTH));
			lblImage.setIcon(imageIcon);
		}

	}

	protected void btnUpdateActionPerformed(ActionEvent e) {
		Book book = new Book();
		DAOBook dao = new DAOBook();
		book.setBookNo(Integer.parseInt(txtBookno.getText()));
		book.setTitle(txtTitle.getText());
		book.setPublisher(txtPublisher.getText());
		book.setAuthor(txtAuthor.getText());
		book.setIsbn(txtISBN.getText());
		book.setShelfNo(Integer.parseInt(txtShelfNo.getText()));
		book.setPages(Integer.parseInt(txtPages.getText()));
		book.setYpublished(dateChooser.getDate());
		book.setPicture(person_image);
		dao.updateBook(book);
		loadData();
	}
	protected void btnDeleteActionPerformed(ActionEvent e) {
		Book book = new Book();
		DAOBook dao = new DAOBook();
		book.setBookNo(Integer.parseInt(txtBookno.getText()));
		book.setStatus(false);
		int ret = JOptionPane.showConfirmDialog(null, "Bạn có chắc chắn xóa ko?");
		if (ret == JOptionPane.YES_OPTION) {
			dao.deleteBook(book);
			loadData();
			}
	}
	protected void btnNewActionPerformed(ActionEvent e) {
		resetData();
	}
	public int showNextId() {
		DAOBook dao = new DAOBook();
		int BookNo=0;
		try (var con = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				PreparedStatement ps = dao.createPSgetMaxId(con);
				ResultSet rs = ps.executeQuery();) {
			if (rs.next()) {
				BookNo=rs.getInt(1);
				BookNo++;
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return BookNo;
	}
	private void resetData() {
		txtBookno.setText(showNextId()+"");
		txtTitle.setText("");
		txtPublisher.setText("");
		txtAuthor.setText("");
		txtISBN.setText("");
		txtPages.setText("");
		txtShelfNo.setText("");
		dateChooser.setDate(null);
		lblImage.setIcon(new ImageIcon(new ImageIcon(getClass().getResource("/images/no-image.png")).getImage()
				.getScaledInstance(lblImage.getWidth(), lblImage.getHeight(), Image.SCALE_SMOOTH)));
	}
}
