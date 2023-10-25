<x-guest-layout >
    <x-auth-card>
        <x-slot name="logo">
        
        </x-slot>

        <!-- Session Status -->
        <x-auth-session-status class="mb-4" :status="session('status')" />

        <!-- Validation Errors -->
        <x-auth-validation-errors class="mb-4" :errors="$errors" />
        <section style="background:linear-gradient(30deg, white,#004593, white, #004593, white);" class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
              <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                  <div class="card  text-black" style="background:linear-gradient(30deg, #004593,#004593, white, white, white);">
                    <div class="card-body p-5 text-center" >
          
                      <div class="mb-md-5 mt-md-4 pb-5">
                        <a href="/">
                            <img src="https://static.wixstatic.com/media/cc9d3c_1f57b51b1a764bed8cc6cd965c43540e~mv2.png/v1/fill/w_194,h_134,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/Logo_Comprolab.png"
                                alt="">
                        </a>
                        
                        <h4 class="text-100 mb-5" style="color: #004593">Activos fijos </h4 >
                        <form method="POST" action="{{ route('login') }}">
                            @csrf
                        <div  class="form-outline form-white mb-4">
                            <x-input-label  for="email" :value="__('Identificacion')" />
            
                            <x-text-input id="identificacion" class="form-control form-control-lg" type="text" name="identificacion" :value="old('identificacion')"
                                required autofocus />
                        </div>
          
                        
                        <div class="mt-4">
                            <x-input-label for="password" :value="__('Password')" />
            
                            <x-text-input id="password" class="form-control form-control-lg" type="password" name="password" required
                                autocomplete="current-password" />
                        </div>
          
                        <div class="flex items-center justify-end mt-4">
                          
            
                            <x-primary-button class="btn btn-outline-light btn-lg px-5">
                                {{ __('Ingresar') }}
                            </x-primary-button>
                        </div>
          
                       
                    </form>
                        <div class="d-flex justify-content-center text-center mt-4 pt-1">
                          <a href="#!" class="text-white"><i class="fab fa-facebook-f fa-lg"></i></a>
                          <a href="#!" class="text-white"><i class="fab fa-twitter fa-lg mx-4 px-2"></i></a>
                          <a href="#!" class="text-white"><i class="fab fa-google fa-lg"></i></a>
                        </div>
          
                      </div>
          
                     
          
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
        
    </x-auth-card>
</x-guest-layout>
