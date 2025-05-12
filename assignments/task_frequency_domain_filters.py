import cv2
import numpy as np
import matplotlib.pyplot as plt
import os

# ========== Task 1: Load and Preprocess Image ==========
# print(f"Path: {os.path.dirname(os.path.realpath(__file__))}")
img = cv2.imread(os.path.dirname(os.path.realpath(__file__)) + '/images/image8.jpg', cv2.IMREAD_GRAYSCALE)
if img is None:
    raise FileNotFoundError("Image not found. Please ensure 'image8.jpg' is in the working directory.")
img = cv2.resize(img, (256, 256))

plt.figure(figsize=(5, 5))
plt.imshow(img, cmap='gray')
plt.title("Grayscale Image")
plt.axis('off')
# plt.show()

# ========== Task 2: Apply Fourier Transform and Show Spectrum ==========
dft = np.fft.fft2(img)
dft_shift = np.fft.fftshift(dft)
magnitude_spectrum = 20 * np.log(np.abs(dft_shift) + 1)

plt.figure(figsize=(5, 5))
plt.imshow(magnitude_spectrum, cmap='gray')
plt.title("Magnitude Spectrum (Centered)")
plt.axis('off')
# plt.show()

# ========== Task 3: Implement Frequency Domain Filters ==========

def ideal_low_pass(shape, radius):
    rows, cols = shape
    crow, ccol = rows // 2, cols // 2
    mask = np.zeros((rows, cols), np.uint8)
    cv2.circle(mask, (ccol, crow), radius, 1, thickness=-1)
    return mask

def ideal_high_pass(shape, radius):
    return 1 - ideal_low_pass(shape, radius)

def gaussian_low_pass(shape, radius):
    rows, cols = shape
    crow, ccol = rows // 2, cols // 2
    x = np.arange(cols)
    y = np.arange(rows)
    x, y = np.meshgrid(x, y)
    d = np.sqrt((x - ccol) ** 2 + (y - crow) ** 2)
    mask = np.exp(-(d ** 2) / (2 * (radius ** 2)))
    return mask

def gaussian_high_pass(shape, radius):
    return 1 - gaussian_low_pass(shape, radius)

# Filter application function
def apply_filter(img, filter_func, radius, title):
    dft = np.fft.fft2(img)
    dft_shift = np.fft.fftshift(dft)
    mask = filter_func(img.shape, radius)
    filtered_dft = dft_shift * mask
    img_back = np.fft.ifft2(np.fft.ifftshift(filtered_dft))
    img_back = np.abs(img_back)

    # Show result
    plt.figure(figsize=(10, 4))
    plt.subplot(1, 3, 1)
    plt.imshow(img, cmap='gray')
    plt.title('Original')
    plt.axis('off')

    plt.subplot(1, 3, 2)
    plt.imshow(mask, cmap='gray')
    plt.title(f'{title} Mask (R={radius})')
    plt.axis('off')

    plt.subplot(1, 3, 3)
    plt.imshow(img_back, cmap='gray')
    plt.title(f'Filtered Image ({title})')
    plt.axis('off')
    plt.tight_layout()
    # plt.show()

# ========== Task 4: Analysis ==========
radii = [10, 30, 60, 160]
for r in radii:
    apply_filter(img, ideal_low_pass, r, f'Ideal Low-pass')
    apply_filter(img, gaussian_low_pass, r, f'Gaussian Low-pass')
    apply_filter(img, ideal_high_pass, r, f'Ideal High-pass')
    apply_filter(img, gaussian_high_pass, r, f'Gaussian High-pass')
plt.show()