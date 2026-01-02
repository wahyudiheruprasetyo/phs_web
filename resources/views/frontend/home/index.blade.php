@extends('layouts.frontend')

@section('title', 'Home - PT Dwi Prima Sentosa')

@section('content')
<!-- Hero Section -->
<section class="py-5 bg-primary text-white">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h1 class="display-4 fw-bold">Footwear Factory With More Than 23 Years Experience</h1>
                <p class="lead">High-quality footwear manufacturing with international standards</p>
                <a href="{{ route('about') }}" class="btn btn-light btn-lg">Learn More</a>
            </div>
            <div class="col-lg-6">
                <img src="https://via.placeholder.com/600x400" class="img-fluid rounded" alt="Factory">
            </div>
        </div>
    </div>
</section>

<!-- About Preview -->
<section class="py-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <h2 class="mb-4">About Our Company</h2>
                <p>PT Dwi Prima Sentosa is located in East Java, with a population of more than 2 million peoples. We are the only footwear manufacturing industry in Ngawi and Madiun.</p>
                <p>Have advantage in the Field of Transportation Local Logistics and Highway integration to port Semarang and Surabaya.</p>
                <a href="{{ route('about') }}" class="btn btn-primary">Read Full Story</a>
            </div>
            <div class="col-lg-6">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <div class="card text-center h-100">
                            <div class="card-body">
                                <h3 class="text-primary">23+</h3>
                                <p>Years Experience</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="card text-center h-100">
                            <div class="card-body">
                                <h3 class="text-primary">2000+</h3>
                                <p>Employees</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="card text-center h-100">
                            <div class="card-body">
                                <h3 class="text-primary">50+</h3>
                                <p>International Clients</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="card text-center h-100">
                            <div class="card-body">
                                <h3 class="text-primary">10M+</h3>
                                <p>Pairs Produced</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Services -->
<section class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center mb-5">Why Choose Us</h2>
        <div class="row">
            @forelse($services as $service)
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">{{ $service->title }}</h5>
                        <p class="card-text">{{ Str::limit($service->description, 100) }}</p>
                    </div>
                </div>
            </div>
            @empty
            <div class="col-12 text-center">
                <p class="text-muted">Services information coming soon.</p>
            </div>
            @endforelse
        </div>
    </div>
</section>

<!-- Recent News -->
<section class="py-5">
    <div class="container">
        <h2 class="text-center mb-5">Latest News & Events</h2>
        <div class="row">
            @forelse($blogs as $blog)
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title">{{ Str::limit($blog->title, 50) }}</h5>
                        <p class="card-text text-muted small">{{ $blog->published_date }}</p>
                        <p class="card-text">{{ $blog->excerpt }}</p>
                        <a href="#" class="btn btn-sm btn-outline-primary">Read More</a>
                    </div>
                </div>
            </div>
            @empty
            <div class="col-12 text-center">
                <p class="text-muted">News information coming soon.</p>
            </div>
            @endforelse
        </div>
    </div>
</section>

<!-- Partners -->
<section class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center mb-5">Our Trusted Partners</h2>
        <div class="row">
            @forelse($buyers as $buyer)
            <div class="col-6 col-md-3 text-center mb-4">
                <div class="bg-white p-3 rounded shadow-sm">
                    <p class="mb-0"><strong>{{ $buyer->name }}</strong></p>
                </div>
            </div>
            @empty
            <div class="col-12 text-center">
                <p class="text-muted">Partners information coming soon.</p>
            </div>
            @endforelse
        </div>
    </div>
</section>
@endsection