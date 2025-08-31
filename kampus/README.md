# Kampus - Student Management System

A Move smart contract for managing student data on the Sui blockchain.

## Overview

The Kampus project is a simple student management system implemented as a Move smart contract. It allows for student registration, course enrollment, and graduation tracking on the Sui blockchain.

## Project Structure

```
kampus/
├── Move.toml          # Project configuration
├── sources/           # Move source files
│   └── kampus.move    # Main module
├── tests/             # Test files
│   └── kampus_tests.move
└── build/             # Compiled bytecode
    └── kampus/
        ├── bytecode_modules/
        └── sources/
```

## Module: `data_mahasiswa_lengkap`

The main module `kampus::data_mahasiswa_lengkap` provides functionality for managing student records.

### Struct: `Mahasiswa`

Represents a student with the following fields:

| Field | Type | Description |
|-------|------|-------------|
| `id` | `UID` | Unique identifier for the student object |
| `nama` | `String` | Student's name |
| `nim` | `u32` | Student ID number |
| `jurusan` | `String` | Student's major/department |
| `umur` | `u8` | Student's age |
| `total_sks` | `u64` | Total credit hours earned |
| `aktif` | `bool` | Whether the student is active |
| `lulus` | `bool` | Whether the student has graduated |

### Public Functions

#### `daftar_mahasiswa`
```move
public fun daftar_mahasiswa(
    nama: String,
    nim: u32,
    jurusan: String,
    umur: u8,
    ctx: &mut TxContext
): Mahasiswa
```

Creates a new student record with the provided information. Initializes `total_sks` to 0, `aktif` to true, and `lulus` to false.

#### `ambil_mata_kuliah`
```move
public fun ambil_mata_kuliah(mhs: &mut Mahasiswa, sks: u64)
```

Adds credit hours (SKS) to a student's total. This simulates enrolling in courses.

#### `set_lulus`
```move
public fun set_lulus(mhs: &mut Mahasiswa)
```

Sets a student's graduation status to true if they have earned at least 144 credit hours.

#### `get_info`
```move
public fun get_info(mhs: &Mahasiswa): (String, u32, u64, bool)
```

Returns basic information about a student: name, student ID, total credit hours, and graduation status.

## Usage Examples

### Creating a New Student
```move
use kampus::data_mahasiswa_lengkap;

// Create a new student
let student = data_mahasiswa_lengkap::daftar_mahasiswa(
    string::utf8(b"John Doe"),
    12345,
    string::utf8(b"Computer Science"),
    20,
    ctx
);
```

### Enrolling in Courses
```move
// Add 3 credit hours to the student's total
data_mahasiswa_lengkap::ambil_mata_kuliah(&mut student, 3);
```

### Checking Graduation Status
```move
// Check if student has enough credits to graduate
data_mahasiswa_lengkap::set_lulus(&mut student);

// Get student information
let (name, nim, sks, graduated) = data_mahasiswa_lengkap::get_info(&student);
```

## Build Instructions

To build the project, ensure you have the Sui CLI installed and run:

```bash
sui move build
```

## Test Instructions

To run tests:

```bash
sui move test
```

Note: The current test suite is minimal and mostly contains placeholder tests.

## Dependencies

- Sui Framework: Uses the official Sui framework from the Mysten Labs repository

## License

This project is licensed under the MIT License.