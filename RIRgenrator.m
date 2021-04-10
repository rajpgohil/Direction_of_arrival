clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('/media/speech/Data/Files/database/dev-other/LibriSpeech/Audiodata/audio_data/2')
addpath('/media/speech/Data/Files/Thesis_data/3')
addpath('/media/speech/Data/Files/Thesis_data/clean/10')
addpath('/media/speech/Data/Files/database/8k-G712/CA')
addpath('/media/speech/Data/Files/database/dev-other/LibriSpeech/Audiodata/audio_data/1')
addpath('/media/speech/Data/Files/database/dev-other/LibriSpeech/Audiodata/20')
addpath('/media/speech/Data/Files/database/SignalGraph-master/signal/feature')
addpath('/media/speech/Data/Files/database/SignalGraph-master/signal/array/imageRIR/Lehmann')
addpath('/media/speech/Data/Files/database/SignalGraph-master/signal/array')
addpath('/media/speech/Data/Files/database/SignalGraph-master/signal/array/imageRIR')
addpath('/media/speech/Data/Files/database/SignalGraph-master/examples/simulation')
addpath('/media/speech/Data/Files/database/SignalGraph-master/examples/simulation/audio')
addpath('/media/speech/Data/Files/chime_kaldi/kaldi/egs/chime6/s5_track1/RIRS_NOISES/pointsource_noises')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=dir('/media/speech/Data/Files/Thesis_data/clean/10/*.flac');
p=dir('/media/speech/Data/Files/chime_kaldi/kaldi/egs/chime6/s5_track1/RIRS_NOISES/pointsource_noises/*.wav');
random_n=randi([1,50],1,1);
a=struct2cell(s);
% random_number=randi([1,10],1,1)
filename=a(1,:);
doa=10;
t=[0.1:0.1:1];
snr=[0];
% ctr_pos=room_size./2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('/media/speech/Data/Files/database/dev-other/LibriSpeech/dev-other/1701/141760')
addpath('/media/speech/Data/Files/database/8k-G712/CA')
addpath('/media/speech/Data/Files/database/dev-other/LibriSpeech/Audiodata/audio data/2')
addpath('/media/speech/Data/Files/database/dev-other/LibriSpeech/Audiodata/20')
addpath('/media/speech/Data/Files/database/SignalGraph-master/signal/feature')
addpath('/media/speech/Data/Files/database/SignalGraph-master/signal/array/imageRIR/Lehmann')
addpath('/media/speech/Data/Files/database/SignalGraph-master/signal/array')
addpath('/media/speech/Data/Files/database/SignalGraph-master/signal/array/imageRIR')
addpath('/media/speech/Data/Files/database/SignalGraph-master/examples/simulation')
addpath('/media/speech/Data/Files/database/SignalGraph-master/examples/simulation/audio')
addpath('/media/speech/Data/Files/chime_kaldi/kaldi/egs/chime6/s5_track1/RIRS_NOISES/pointsource_noises')
% [wav_clean,fs] = audioread('116-288045-0000.flac'); % a clean sentence taking from Libri corpus train set
% wav_noise = audioread('audio/noise-sound-bible-0003.wav'); % a noise signal taking from MUSAN corpus
useGPU = 0; % whether to use GPU
% the following parameters can be randomly sampled from a distribution
% SNR = 10;   % signal-to-noise ratio in dB
% t60 = 0.1;  % reverberation T60 time measure how long it takes for the reverberation to decreases its power by 60dB

% RIR = genMultiChannelRIR(t60, useGPU,src_pos)';    % generate the room impulse responses
% 
% [distorted, reverb_only] = ApplyConstRirNoise(wav_clean, fs, RIR, wav_noise, SNR, useGPU);
% distorted = gather(distorted);      % move data from GPU to CPU memory
% reverb_only = gather(reverb_only);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:170;
    [wav_clean,fs]=audioread(s(j).name);
    random_n=randi([1,50],1,1);
    [wav_noise,fsn]=audioread(p(random_n).name)
    n=erase(s(j).name,'.wav')
    for i=1;
        SNR=snr(i)
        random_number=randi([1,10],1,1)
        t60=t(random_number);
        useGPU=0;
        RIR = genMultiChannelRIR(t60, useGPU,doa)';    % generate the room impulse responses
        [distorted, reverb_only] = ApplyConstRirNoise(wav_clean, fs, RIR, wav_noise, SNR, useGPU);
        fname=sprintf('%s_%d_%d_%d.wav',erase(s(j).name,'.flac'),i,SNR,doa);
        distorted = gather(distorted);      % move data from GPU to CPU memory
        reverb_only = gather(reverb_only);
        audiowrite(fname,reverb_only,fs)
    end
end
