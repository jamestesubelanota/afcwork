<x-guest-layout>
    <x-auth-card>
        <x-slot name="logo">
            <a href="/">
                <img src="https://static.wixstatic.com/media/cc9d3c_1f57b51b1a764bed8cc6cd965c43540e~mv2.png/v1/fill/w_194,h_134,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/Logo_Comprolab.png"
                    alt="">
            </a>
        </x-slot>

        <!-- Session Status -->
        <x-auth-session-status class="mb-4" :status="session('status')" />

        <!-- Validation Errors -->
        <x-auth-validation-errors class="mb-4" :errors="$errors" />

        <form method="POST" action="{{ route('login') }}">
            @csrf

            <!-- Email Address -->
            <div>
                <x-input-label for="email" :value="__('Email')" />

                <x-text-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')"
                    required autofocus />
            </div>

            <!-- Password -->
            <div class="mt-4">
                <x-input-label for="password" :value="__('Password')" />

                <x-text-input id="password" class="block mt-1 w-full" type="password" name="password" required
                    autocomplete="current-password" />
            </div>

            <!-- Remember Me -->
           

            <div class="flex items-center justify-end mt-4">
                @if (Route::has('password.request'))
                    <a class="underline text-sm text-gray-600 hover:text-gray-900"
                        href="{{ route('password.request') }}">
                        {{ __('Olvidaste tu contraseña') }}
                    </a>
                @endif

                <x-primary-button class="ml-3">
                    {{ __('Ingresar') }}
                </x-primary-button>
            </div>
        </form>
    </x-auth-card>
</x-guest-layout>
