const SectionHeading = ({ title }: { title: string }) => {
  return (
    <div className="bg-white pt-12 sm:pt-16">
      <h2 className="font-display px-[5%] text-2xl tracking-tight text-black sm:text-3xl md:text-4xl">
        {title}
      </h2>
      <div className="-mt-1 border-b-8 border-black" />
    </div>
  );
};

export default SectionHeading;
