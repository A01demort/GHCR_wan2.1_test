#!/bin/bash
# set -e ❌ 제거 (중간 실패로 전체 중단 방지)

echo "🌀 RunPod 재시작 시 의존성 복구 시작"

############################################
# 📦 코어 파이썬 패키지 (ComfyUI 필수)
############################################
echo '📦 코어 파이썬 패키지 설치'

pip install torchsde || echo '⚠️ torchsde 설치 실패'
pip install av || echo '⚠️ av 설치 실패'
pip install torchaudio || echo '⚠️ torchaudio 설치 실패'

############################################
# 📦 일반 파이썬 패키지 (Dockerfile에서 이동)
############################################
echo '📦 파이썬 패키지 설치'

pip install --no-cache-dir \
    GitPython onnx onnxruntime opencv-python-headless tqdm requests \
    scikit-image piexif packaging transformers accelerate peft sentencepiece \
    protobuf scipy einops pandas matplotlib imageio[ffmpeg] pyzbar pillow numba \
    gguf diffusers insightface dill || echo '⚠️ 일부 pip 설치 실패'

pip install facelib==0.2.2 mtcnn==0.1.1 || echo '⚠️ facelib 실패'
pip install facexlib basicsr gfpgan realesrgan || echo '⚠️ facexlib 실패'
pip install timm || echo '⚠️ timm 실패'
pip install ultralytics || echo '⚠️ ultralytics 실패'
pip install ftfy || echo '⚠️ ftfy 실패'
pip install bitsandbytes xformers || echo '⚠️ bitsandbytes 또는 xformers 설치 실패'
pip install sageattention || echo '⚠️ sageattention 설치 실패'

############################################
# 📁 커스텀 노드 설치 (안 깨지게 서브셸로)
############################################
echo '📁 커스텀 노드 및 의존성 설치 시작'

mkdir -p /workspace/ComfyUI/custom_nodes

(
cd /workspace/ComfyUI/custom_nodes || exit 0

git clone https://github.com/ltdrdata/ComfyUI-Manager.git && (cd ComfyUI-Manager && git checkout 116e068ac31c8b76860cd7aa369d5aacd61d27dc) || echo '⚠️ Manager 실패'
git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git && (cd ComfyUI-Custom-Scripts && git checkout f2838ed5e59de4d73cde5c98354b87a8d3200190) || echo '⚠️ Scripts 실패'
git clone https://github.com/rgthree/rgthree-comfy.git && (cd rgthree-comfy && git checkout 110e4ef1dbf2ea20ec39ae5a737bd5e56d4e54c2) || echo '⚠️ rgthree 실패'
git clone https://github.com/WASasquatch/was-node-suite-comfyui.git && (cd was-node-suite-comfyui && git checkout ea935d1044ae5a26efa54ebeb18fe9020af49a45) || echo '⚠️ WAS 실패'
git clone https://github.com/kijai/ComfyUI-KJNodes.git && (cd ComfyUI-KJNodes && git checkout e2ce0843d1183aea86ce6a1617426f492dcdc802) || echo '⚠️ KJNodes 실패'
git clone https://github.com/cubiq/ComfyUI_essentials.git && (cd ComfyUI_essentials && git checkout 9d9f4bedfc9f0321c19faf71855e228c93bd0dc9) || echo '⚠️ Essentials 실패'
git clone https://github.com/city96/ComfyUI-GGUF.git && (cd ComfyUI-GGUF && git checkout d247022e3fa66851c5084cc251b076aab816423d) || echo '⚠️ GGUF 실패'
git clone https://github.com/welltop-cn/ComfyUI-TeaCache.git && (cd ComfyUI-TeaCache && git checkout 91dff8e31684ca70a5fda309611484402d8fa192) || echo '⚠️ TeaCache 실패'
git clone https://github.com/kaibioinfo/ComfyUI_AdvancedRefluxControl.git && (cd ComfyUI_AdvancedRefluxControl && git checkout 2b95c2c866399ca1914b4da486fe52808f7a9c60) || echo '⚠️ ARC 실패'
git clone https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git && (cd ComfyUI_Comfyroll_CustomNodes && git checkout d78b780ae43fcf8c6b7c6505e6ffb4584281ceca) || echo '⚠️ Comfyroll 실패'
git clone https://github.com/cubiq/PuLID_ComfyUI.git && (cd PuLID_ComfyUI && git checkout 93e0c4c226b87b23c0009d671978bad0e77289ff) || echo '⚠️ PuLID 실패'
git clone https://github.com/sipie800/ComfyUI-PuLID-Flux-Enhanced.git && (cd ComfyUI-PuLID-Flux-Enhanced && git checkout 04e1b52320f1f14383afe18959349703623c5b88) || echo '⚠️ Flux 실패'
git clone https://github.com/Gourieff/ComfyUI-ReActor.git && (cd ComfyUI-ReActor && git checkout d60458f212e8c7a496269bbd29ca7c6a3198239a) || echo '⚠️ ReActor 실패'
git clone https://github.com/yolain/ComfyUI-Easy-Use.git && (cd ComfyUI-Easy-Use && git checkout 11794f7d718dc38dded09e677817add796ce0234) || echo '⚠️ EasyUse 실패'
git clone https://github.com/PowerHouseMan/ComfyUI-AdvancedLivePortrait.git && (cd ComfyUI-AdvancedLivePortrait && git checkout 3bba732915e22f18af0d221b9c5c282990181f1b) || echo '⚠️ LivePortrait 실패'
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && (cd ComfyUI-VideoHelperSuite && git checkout 8e4d79471bf1952154768e8435a9300077b534fa) || echo '⚠️ VideoHelper 실패'
git clone https://github.com/Jonseed/ComfyUI-Detail-Daemon.git && (cd ComfyUI-Detail-Daemon && git checkout f391accbda2d309cdcbec65cb9fcc80a41197b20) || echo '⚠️ Daemon 실패'
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git && (cd ComfyUI_UltimateSDUpscale && git checkout 627c871f14532b164331f08d0eebfbf7404161ee) || echo '⚠️ Upscale 실패'
git clone https://github.com/risunobushi/comfyUI_FrequencySeparation_RGB-HSV.git && (cd comfyUI_FrequencySeparation_RGB-HSV && git checkout 67a08c55ee6aa8e9140616f01497bd54d3533fa6) || echo '⚠️ Frequency 실패'
git clone https://github.com/silveroxides/ComfyUI_bnb_nf4_fp4_Loaders.git && (cd ComfyUI_bnb_nf4_fp4_Loaders && git checkout dd2f774a2d3930de06fddc995901c830fc936715) || echo '⚠️ NF4 노드 실패'
git clone https://github.com/kijai/ComfyUI-FramePackWrapper.git && (cd ComfyUI-FramePackWrapper && git checkout a7c4b704455aee0d016143f2fc232928cc0f1d83) || echo '⚠️ FramePackWrapper 실패'
git clone https://github.com/pollockjj/ComfyUI-MultiGPU.git && (cd ComfyUI-MultiGPU && git checkout 6e4181a7bb5e2ef147aa8e1d0845098a709306a4) || echo '⚠️ MultiGPU 실패'
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git && (cd comfyui_controlnet_aux && git checkout 59b027e088c1c8facf7258f6e392d16d204b4d27) || echo '⚠️ controlnet_aux 실패'
git clone https://github.com/chflame163/ComfyUI_LayerStyle.git && (cd ComfyUI_LayerStyle && git checkout 3bfe8e4) || echo '⚠️ ComfyUI_LayerStyle 설치 실패'
git clone https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git && (cd ComfyUI-Frame-Interpolation && git checkout a969c01dbccd9e5510641be04eb51fe93f6bfc3d) || echo '⚠️ Frame-Interpolation 실패'
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && (cd ComfyUI-Impact-Pack && git checkout 48a814315f500a6f3e87ac4c8446305f8b2ef8f6) || echo '⚠️ Impact-Pack 실패'
git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git && (cd ComfyUI-WanVideoWrapper && git checkout 6eddec54a69d9fac30b0125a3c06656e7c533eca) || echo '⚠️ ComfyUI-WanVideoWrapper 설치 실패'
)

############################################
# 📦 segment-anything 설치 (원본 유지)
############################################
echo '📦 segment-anything 설치'
git clone https://github.com/facebookresearch/segment-anything.git /workspace/segment-anything || echo '⚠️ segment-anything 실패'
pip install -e /workspace/segment-anything || echo '⚠️ segment-anything pip 설치 실패'

############################################
# 📦 ReActor ONNX 모델 설치 (원본 유지)
############################################
echo '📦 ReActor ONNX 모델 설치'
mkdir -p /workspace/ComfyUI/models/insightface
wget -O /workspace/ComfyUI/models/insightface/inswapper_128.onnx \
https://huggingface.co/datasets/Gourieff/ReActor/resolve/main/models/inswapper_128.onnx || echo '⚠️ ONNX 다운로드 실패'

############################################
# ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇
# 👉 기존 init 구조 (그대로 유지)
############################################

cd /workspace/ComfyUI/custom_nodes || {
  echo "⚠️ custom_nodes 디렉토리 없음. ComfyUI 설치 전일 수 있음"
  exit 0
}

for d in */; do
  req_file="${d}requirements.txt"
  marker_file="${d}.installed"

  if [ -f "$req_file" ]; then
    if [ -f "$marker_file" ]; then
      echo "⏩ $d 이미 설치됨, 건너뜀"
      continue
    fi

    echo "📦 $d 의존성 설치 중..."
    if pip install -r "$req_file"; then
      touch "$marker_file"
    else
      echo "⚠️ $d 의존성 설치 실패 (무시하고 진행)"
    fi
  fi
done

echo "✅ 모든 커스텀 노드 의존성 복구 완료"
echo "🚀 다음 단계로 넘어갑니다"
echo -e "\n====🎓 AI 교육 & 커뮤니티 안내====\n"
echo -e "1. Youtube : https://www.youtube.com/@A01demort"
echo "2. 교육 문의 : https://a01demort.com"
echo "3. Udemy 강의 : https://bit.ly/comfyclass"
echo "4. Stable AI KOREA : https://cafe.naver.com/sdfkorea"
echo "5. 카카오톡 오픈채팅방 : https://open.kakao.com/o/gxvpv2Mf"
echo "6. CIVITAI : https://civitai.com/user/a01demort"
echo -e "\n==================================="
