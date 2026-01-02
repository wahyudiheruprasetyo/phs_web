@extends('layouts.frontend')

@section('title', 'About Us - PT Dwi Prima Sentosa')

@section('content')
<!-- Page Header -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h1 class="display-5 fw-bold">About Us</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">About Us</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</section>

<!-- About Content -->
<section class="py-5">
    <div class="container">
        @if($about)
        <div class="row mb-5">
            <div class="col-lg-6">
                <h2 class="mb-4">{{ $about->title ?? 'About PT Dwi Prima Sentosa' }}</h2>
                <div class="mb-4">
                    <p>{!! nl2br(e($about->description1 ?? 'PT Dwi Prima Sentosa is located in East Java, with a population of more than 2 million peoples. We are the only footwear manufacturing industry in Ngawi and Madiun.')) !!}</p>
                    <p>{!! nl2br(e($about->description2 ?? 'The company founded by Mr. Han Chacan, a Korean-born individual who is now an Indonesian citizen, began operations in 2002 in East Java. Over 23 years, the company has known for its high-quality products and strong reputation in both domestic and international markets.')) !!}</p>
                </div>
            </div>
            <div class="col-lg-6">
                @if($about->path_image)
                <img src="{{ asset('storage/' . $about->path_image) }}" alt="About PT Dwi Prima Sentosa" class="img-fluid rounded shadow">
                @else
                <img src="https://via.placeholder.com/600x400" alt="About PT Dwi Prima Sentosa" class="img-fluid rounded shadow">
                @endif
            </div>
        </div>

        <!-- Vision & Mission -->
        <div class="row mb-5">
            <div class="col-lg-6 mb-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body p-4">
                        <h3 class="card-title text-primary mb-4">
                            <i class="fas fa-bullseye me-2"></i> Our Vision
                        </h3>
                        <p class="card-text">{!! nl2br(e($about->visi ?? 'Realizing product achievement with standard, efficient, continuous improvement while respecting social responsibility')) !!}</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mb-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body p-4">
                        <h3 class="card-title text-primary mb-4">
                            <i class="fas fa-flag me-2"></i> Our Mission
                        </h3>
                        <p class="card-text">{!! nl2br(e($about->misi ?? 'To be a footwear company that provides value for all people, the environment and nature')) !!}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Philosophy -->
        <div class="row mb-5">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-5">
                        <h3 class="text-primary mb-4">
                            <i class="fas fa-lightbulb me-2"></i> Our Philosophy
                        </h3>
                        <div class="lead">
                            {!! $about->filosofi ?? '<p>We have a clear direction and a predetermined target, so we are committed from top to bottom management with great enthusiasm to achieve the specified target.</p>
                            <p>Our core philosophy revolves around elevating customer satisfaction to the forefront of our management approach. Our unwavering commitment is to consistently deliver excellence in quality, adhere to precise timelines, manage costs effectively, and provide unparalleled service to our valued customers.</p>
                            <p>We firmly believe that a satisfied customer is our greatest asset, and we align our corporate activities to reflect this belief. Our aim is to exceed customer\'s expectations at every turn, ensuring that customer\'s experience with us is nothing short of exceptional.</p>
                            <p>Our corporate ethos is deeply rooted in compliance with laws and adherence to social norms. We are steadfast in our commitment to upholding public order while contributing positively to society through principled and equitable corporate practices.</p>
                            <p>Through conscientious and equitable corporate activities, we aim to set an example of responsible business conduct, one that prioritizes societal well-being, diversity, and sustainability. We believe that by acting in accordance with these principles, we can forge a better, more inclusive future for all.</p>' !!}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Company Values -->
        <div class="row">
            <div class="col-12">
                <h3 class="text-center mb-5">Our Values</h3>
                <div class="bg-light p-5 rounded text-center">
                    <p class="lead fw-bold">{!! nl2br(e($about->value ?? 'Work Smart - Ensure Product Precision - Honor One Planet - Lift as We Rise - Employees are Family - More Than a Manufacture')) !!}</p>
                </div>
            </div>
        </div>
        @else
        <!-- Jika data about tidak ada -->
        <div class="row">
            <div class="col-12 text-center py-5">
                <i class="fas fa-info-circle fa-3x text-muted mb-4"></i>
                <h3 class="text-muted">About Information Coming Soon</h3>
                <p class="text-muted">We are preparing our company profile information.</p>
                <a href="{{ route('home') }}" class="btn btn-primary mt-3">Back to Home</a>
            </div>
        </div>
        @endif
    </div>
</section>

<!-- Company Stats -->
<section class="py-5 bg-primary text-white">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-3 col-6 mb-4">
                <h2 class="display-4 fw-bold">23+</h2>
                <p>Years Experience</p>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <h2 class="display-4 fw-bold">2000+</h2>
                <p>Employees</p>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <h2 class="display-4 fw-bold">50+</h2>
                <p>International Clients</p>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <h2 class="display-4 fw-bold">10M+</h2>
                <p>Pairs Produced</p>
            </div>
        </div>
    </div>
</section>

<!-- Location -->
<section class="py-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h3 class="text-center mb-5">Our Location</h3>
                <div class="row">
                    <div class="col-lg-6 mb-4">
                        <div class="card h-100 border-0 shadow-sm">
                            <div class="card-body p-4">
                                <h4 class="card-title mb-4">
                                    <i class="fas fa-map-marker-alt text-primary me-2"></i> Factory Address
                                </h4>
                                <p class="card-text">
                                    <strong>PT Dwi Prima Sentosa</strong><br>
                                    Cabean, Karang Tengah Prandon<br>
                                    Ngawi, Ngawi Regency<br>
                                    East Java 63218, Indonesia
                                </p>
                                <div class="mt-4">
                                    <p><i class="fas fa-phone me-2"></i> +62 351 4477985</p>
                                    <p><i class="fas fa-envelope me-2"></i> info@dwiprimasentosa.com</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
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
        </div>
    </div>
</section>
@endsection