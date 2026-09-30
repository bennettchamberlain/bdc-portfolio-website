import { site } from "@/data/site";

const Marquee = () => {
  const text = `${site.marquee}  ·  `.repeat(6);

  return (
    <div className="overflow-hidden border-y-8 border-black bg-white">
      <p className="animate-marquee font-body py-3 text-xl font-black tracking-tight whitespace-nowrap sm:text-3xl md:text-5xl">
        {text}
      </p>
      <style>{`
        @keyframes marquee {
          0% { transform: translateX(0); }
          100% { transform: translateX(-50%); }
        }
        .animate-marquee {
          display: inline-block;
          min-width: 200%;
          animation: marquee 28s linear infinite;
        }
      `}</style>
    </div>
  );
};

export default Marquee;
