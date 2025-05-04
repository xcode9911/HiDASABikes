package modal;

import java.sql.Blob;


import java.util.ArrayList;
import java.util.List;

public class User {
	private int userId;
	private String name;
	private String email;
	private String phone;
	private String password;
	private byte[] profileImage;
	private String role;
	private List<Address> addresses;

	// Default constructor
	public User() {
		this.addresses = new ArrayList<>();
	}

	// Constructor with all fields
	public User(int userId, String name, String email, String phone, String password, byte[] profileImage, String role) {
		this.userId = userId;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.password = password;
		this.profileImage = profileImage;
		this.role = role;
		this.addresses = new ArrayList<>();
	}

	// Getters and Setters
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public byte[] getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(byte[] blob) {
		this.profileImage = blob;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public List<Address> getAddresses() {
		return addresses;
	}

	public void setAddresses(List<Address> addresses) {
		this.addresses = addresses;
	}

	// Method to add an address
	public void addAddress(Address address) {
		if (this.addresses == null) {
			this.addresses = new ArrayList<>();
		}
		this.addresses.add(address);
	}

	// Method to remove an address
	public void removeAddress(Address address) {
		if (this.addresses != null) {
			this.addresses.remove(address);
		}
	}

	@Override
	public String toString() {
		return "User{" +
				"userId=" + userId +
				", name='" + name + '\'' +
				", email='" + email + '\'' +
				", phone='" + phone + '\'' +
				", role='" + role + '\'' +
				", addresses=" + addresses +
				'}';
	}
}
