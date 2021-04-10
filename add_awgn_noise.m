clear all;
s=dir('/media/speech/Data/Files/Thesis_data/coprime_reverberated/90/train/*.wav');
p=dir('/media/speech/Data/Files/chime_kaldi/kaldi/egs/chime6/s5_track1/RIRS_NOISES/pointsource_noises/*.wav');
a=struct2cell(s);
filename=a(1,:);
snr=[0,10,15,20,25];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('/media/speech/Data/Files/Thesis_data/coprime_reverberation/10  ');
addpath('/media/speech/Data/Files/Thesis_data/coprime_reverberated/90/train');
addpath('/media/speech/Data/Files/Thesis_data/only_reverberated/60')
addpath('/media/speech/Data/Files/database/dev-other/LibriSpeech/Audiodata/audio_data/2')
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:170;
    [signal,fs]=audioread(s(j).name);
    random_n=randi([1,50],1,1);
    [noise,fsn]=audioread(p(random_n).name)
    for i=1:5;
        SNR=snr(i)
        noisy=awgn(signal,SNR,'measured')
%         S = length( signal );
%         N = length( noise );
%         if N>S
%             R = randi(1+N-S);
%         else
%             noise=repmat(noise,30,1);
%             N=length(noise);
%             R=randi(1+N-S);
%         end
%         noise = noise(R:R+S-1);
%         noise = noise / norm(noise) * norm(signal) / 10.0^(0.05*SNR);
%         noisy = signal + noise;
        fname=sprintf('%s_%d_%d.wav',erase(s(j).name,'.wav'),i,SNR);
        audiowrite(fname,noisy,fs)
    end
end
