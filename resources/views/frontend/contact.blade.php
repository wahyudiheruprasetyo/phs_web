@extends('layouts.frontend')

@section('title', 'Contact Us - PT Dwi Prima Sentosa')

@section('content')
<!-- Page Header -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h1 class="display-5 fw-bold">Contact Us</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Contact Us</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</section>

<!-- Contact Content -->
<section class="py-5">
    <div class="container">
        <div class="row mb-5">
            <div class="col-lg-8 mx-auto text-center">
                <h2 class="mb-4">Get In Touch</h2>
                <p class="lead mb-4">Have questions or want to work with us? Feel free to contact us using the information below or fill out the contact form.</p>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <!-- Contact Info -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body p-4">
                        <h4 class="card-title mb-4">Contact Information</h4>
                        
                        <div class="d-flex mb-4">
                            <div class="flex-shrink-0">
                                <i class="fas fa-map-marker-alt text-primary fa-lg"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6>Address</h6>
                                <p class="text-muted mb-0">
                                    Cabean, Karang Tengah Prandon<br>
                                    Ngawi, Ngawi Regency<br>
                                    East Java 63218, Indonesia
                                </p>
                            </div>
                        </div>

                        <div class="d-flex mb-4">
                            <div class="flex-shrink-0">
                                <i class="fas fa-phone text-primary fa-lg"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6>Phone Number</h6>
                                <p class="text-muted mb-0">+62 351 4477985</p>
                            </div>
                        </div>

                        <div class="d-flex mb-4">
                            <div class="flex-shrink-0">
                                <i class="fas fa-envelope text-primary fa-lg"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6>Email Address</h6>
                                <p class="text-muted mb-0">info@dwiprimasentosa.com</p>
                            </div>
                        </div>

                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <i class="fas fa-clock text-primary fa-lg"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6>Working Hours</h6>
                                <p class="text-muted mb-0">
                                    Monday - Friday: 8:00 AM - 5:00 PM<br>
                                    Saturday: 8:00 AM - 12:00 PM<br>
                                    Sunday: Closed
                                </p>
                            </div>
                        </div>

                        <hr class="my-4">

                        <h6 class="mb-3">Follow Us</h6>
                        <div class="d-flex gap-3">
                            <a href="https://www.instagram.com/ptdwiprimasentosa/" class="text-decoration-none" target="_blank">
                                <i class="fab fa-instagram fa-lg text-primary"></i>
                            </a>
                            <a href="https://www.linkedin.com/company/pt-dwi-prima-sentosa/" class="text-decoration-none" target="_blank">
                                <i class="fab fa-linkedin fa-lg text-primary"></i>
                            </a>
                            <a href="https://www.youtube.com/@dpsngawi" class="text-decoration-none" target="_blank">
                                <i class="fab fa-youtube fa-lg text-primary"></i>
                            </a>
                            <a href="mailto:info@dwiprimasentosa.com" class="text-decoration-none">
                                <i class="fas fa-envelope fa-lg text-primary"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4">
                        <h4 class="card-title mb-4">Send Us a Message</h4>
                        
                        @if(session('success'))
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            {{ session('success') }}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        @endif

                        <form action="{{ route('contact') }}" method="POST">
                            @csrf
                            
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Full Name *</label>
                                    <input type="text" class="form-control @error('name') is-invalid @enderror" 
                                           id="name" name="name" value="{{ old('name') }}" required>
                                    @error('name')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email Address *</label>
                                    <input type="email" class="form-control @error('email') is-invalid @enderror" 
                                           id="email" name="email" value="{{ old('email') }}" required>
                                    @error('email')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                
                                <div class="col-12">
                                    <label for="subject" class="form-label">Subject *</label>
                                    <input type="text" class="form-control @error('subject') is-invalid @enderror" 
                                           id="subject" name="subject" value="{{ old('subject') }}" required>
                                    @error('subject')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                
                                <div class="col-12">
                                    <label for="message" class="form-label">Message *</label>
                                    <textarea class="form-control @error('message') is-invalid @enderror" 
                                              id="message" name="message" rows="5" required>{{ old('message') }}</textarea>
                                    @error('message')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        <i class="fas fa-paper-plane me-2"></i> Send Message
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Map -->
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-0">
                        <div class="ratio ratio-16x9">
                            <iframe 
                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3957.2925381669124!2d111.4799218!3d-7.4088789!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e79dd537db1718f%3A0xb7b2929065ee3d7d!2sPT.%20Dwi%20Prima%20Sentosa!5e0!3m2!1sen!2sid!4v1621234567890!5m2!1sen!2sid"
                                style="border:0;" 
                                allowfullscreen="" 
                                loading="lazy">
                            </iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
@endsection